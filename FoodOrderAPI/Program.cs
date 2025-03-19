
using Services.Implements;
using Services.Interfaces;
using Repositories.Implements;
using Repositories.Interfaces;

namespace FoodOrderAPI
{
    public class Program
    {
        public static void Main(string[] args)
        {
            var builder = WebApplication.CreateBuilder(args);

            var connectionString = builder.Configuration.GetConnectionString("DefaultConnection");

            if (string.IsNullOrEmpty(connectionString))
            {
                throw new InvalidOperationException("?? ConnectionString is not set! check appsettings.json or launchSettings.json.");
            }

            // Add services to the container.

            builder.Services.AddControllers();
            // Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
            builder.Services.AddEndpointsApiExplorer();
            builder.Services.AddSwaggerGen();

            builder.Services.AddScoped<IRestaurantManagementService, RestaurantManagementService>();
            builder.Services.AddScoped<IRestaurantManagementRepository>(sp => new RestaurantManagementRepository(connectionString));

            builder.Services.AddScoped<IOrderManagementService, OrderManagementService>();
            builder.Services.AddScoped<IOrderManagementRepository>(sp => new OrderManagementRepository(connectionString));

            // Thêm CORS
            builder.Services.AddCors(options =>
            {
                options.AddPolicy("AllowAll",
                    policy => policy.AllowAnyOrigin()
                                    .AllowAnyMethod()
                                    .AllowAnyHeader());
            });


            


            var app = builder.Build();

            // Configure the HTTP request pipeline.
            if (app.Environment.IsDevelopment())
            {
                app.UseSwagger();
                app.UseSwaggerUI();
                app.UseSwaggerUI(c =>
                {
                    c.SwaggerEndpoint("/swagger/v1/swagger.json", "FoodOrder API v1");
                    c.RoutePrefix = string.Empty; //  Swagger ngay t?i http://localhost:7299/
                });
            }

            // S? d?ng CORS
            app.UseCors("AllowAll");

            app.UseHttpsRedirection();

            app.UseAuthorization();
  

            app.MapControllers();

            app.Run();
        }
    }
}
