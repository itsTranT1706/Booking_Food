using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Services.Interfaces;

namespace FoodOrderAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class OrderController : ControllerBase
    {
        private readonly IOrderManagementService _orderManagementService;

        public OrderController(IOrderManagementService orderManagementService)
        {

            _orderManagementService = orderManagementService;
        }

        [HttpGet("orders-with-orderdetails")]
        public async Task<IActionResult> GetAllRestaurantsWithFoodsGetOrderWithOrderDetailByAccountIDAndOrderStatus(int AccountID , int OrderStatus)
        {
            var data = await _orderManagementService.GetOrderWithOrderDetailByAccountIDAndOrderStatus(AccountID, OrderStatus);
            if (data == null || !data.Any())
            {
                return NotFound("No results found.");
            }
            return Ok(data);
        }
    }
}
