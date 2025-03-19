using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Repositories.Dtos;
using Services.Interfaces;

namespace FoodOrderAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class RestaurantController : ControllerBase
    {
        private readonly IRestaurantManagementService _restaurantManagementService;

        public RestaurantController(IRestaurantManagementService restaurantManagementService)
        {

            _restaurantManagementService = restaurantManagementService;
        }

        [HttpGet]
        public async Task<IActionResult> GetRestaurantList()
        {
            try
            {
                var data = await _restaurantManagementService.GetRestaurantList();

                if (data == null || !data.Any())
                {
                    return NotFound("Không có dữ liệu trong database.");
                }

                return Ok(data);
            }
            catch (Exception ex)
            {
                return StatusCode(500, $"Lỗi Server: {ex.Message}");    
            }
        }


        [HttpGet("{restaurantID}/foods")]
        public async Task<IActionResult> GetFoodListByRestaurantID([FromRoute] int restaurantID)
        {
            var data =  await _restaurantManagementService.GetFoodListByRestaurantID(restaurantID);
            if (data == null || !data.Any())
            {
                return NotFound($"No foods found for restaurant ID {restaurantID}");
            }
            return Ok(data);
        }


        [HttpGet("{commoncategoryID}")]

        public async Task<IActionResult> GetRestaurantListByCommonCategoryID ( int commoncategoryID)
        {
            var data = await _restaurantManagementService.GetRestaurantListByCommonCategoryID(commoncategoryID);
            return Ok(data);
        }

        [HttpGet("{searchstring}/resultsearch")]
        public async Task<IActionResult> GetRestaurantListByRestaurantNameOrFoodName([FromRoute] string searchstring)
        {
            var data = await _restaurantManagementService.GetRestaurantListByRestaurantNameOrFoodName(searchstring);
            return Ok(data);
        }


        [HttpGet("restaurants-with-foods")]
        public async Task<IActionResult> GetAllRestaurantsWithFoods()
        {
            var data = await _restaurantManagementService.GetRestaurantWithFoods();
            if (data == null || !data.Any())
            {
                return NotFound("No results found.");
            }
            return Ok(data);
        }

        [HttpPost("update-food")]
        
        public async Task<IActionResult> UpdateFood( Food food)
        {
            var data = await _restaurantManagementService.UpdateFood(food);
            return Ok(data);
        }




    }
}
