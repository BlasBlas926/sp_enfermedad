using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Enfermedades.Models;
using Microsoft.EntityFrameworkCore;

namespace Enfermedades.Data
{
    public class CatalogosDbContext: DbContext
    {
        public CatalogosDbContext(DbContextOptions<CatalogosDbContext> options): base(options)
        {
        }

        public DbSet<Catalogos> Catalogos { get; set; }
    }
}