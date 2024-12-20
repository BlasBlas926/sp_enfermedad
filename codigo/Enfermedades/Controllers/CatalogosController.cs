using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Threading.Tasks;
using Enfermedades.Data;
using Enfermedades.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;

namespace Enfermedades.Controllers
{

    public class CatalogosController : Controller
    {
        private readonly CatalogosDbContext _context;

        public CatalogosController(CatalogosDbContext context)
        {
            _context = context;
        }

        public async Task<IActionResult> Index()
        {
            var productos = await _context.Catalogos.FromSqlRaw("SELECT * FROM schemasye.obtener_todos_enfermedades()").ToListAsync();
            return View(productos);
        }
        public IActionResult Create()
        {
            return View();
        }
        [HttpPost]
        public async Task<IActionResult> Create(Catalogos catalogos)
        {
            await _context.Database.ExecuteSqlRawAsync("SELECT * FROM schemasye.agregar_enfermedad({0},{1},{2},{3},{4},{5})",
            catalogos.Nombre, catalogos.Descripcion, catalogos.FechaRegistro, catalogos.FechaInicio, catalogos.FechaActualizacion, catalogos.Estado);
            return RedirectToAction("Index");
        }
        public async Task<IActionResult> Details(int id)
        {
            var catalogos = await _context.Catalogos
            .FromSqlRaw("SELECT *FROM schemasye.obtener_id_enfermedad({0})", id)
              .FirstOrDefaultAsync();
            return View(catalogos);
        }
        public async Task<IActionResult> Edit(int id)
        {
            var catalogos = await _context.Catalogos
            .FromSqlRaw("SELECT *FROM schemasye.obtener_id_enfermedad({0})", id)
              .FirstOrDefaultAsync();
            return View(catalogos);
        }
        [HttpPost]
        public async Task<IActionResult> Edit(Catalogos catalogos)
        {
            await _context.Database.ExecuteSqlRawAsync("SELECT * FROM schemasye.actualizar_enfermedad({0},{1},{2},{3},{4},{5},{6})",
            catalogos.Id, catalogos.Nombre, catalogos.Descripcion, catalogos.FechaRegistro, catalogos.FechaInicio, catalogos.FechaActualizacion, catalogos.Estado);
            return RedirectToAction("Index");
        }
        public async Task<IActionResult> Delete(int id)
        {
            var catalogos = await _context.Catalogos
            .FromSqlRaw("SELECT *FROM schemasye.obtener_id_enfermedad({0})", id)
              .FirstOrDefaultAsync();
            return View(catalogos);
        }
        [HttpPost]
        public async Task<IActionResult> Delete(Catalogos catalogos)
        {
            await _context.Database.ExecuteSqlRawAsync("SELECT * FROM schemasye.eliminar_enfermedad({0})", catalogos.Id);
            return RedirectToAction("Index");
        }
    }
}
