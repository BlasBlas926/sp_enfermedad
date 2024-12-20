using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Threading.Tasks;

namespace Enfermedades.Models
{
    public class Catalogos
    {
        [Column("id_enf_cronica")]
        public int Id { get; set; }
        [Column("nombre")]
        public string? Nombre { get; set; }
        [Column("descripcion")]
        public string? Descripcion { get; set; }
        [Column("fecha_registro")]
        public DateOnly FechaRegistro { get; set; }
        [Column("fecha_inicio")]
        public DateOnly FechaInicio { get; set; }
        [Column("fecha_actualizacion")]
        public DateOnly FechaActualizacion { get; set; }
        [Column("estado")]
        public bool Estado { get; set; }
    }
}