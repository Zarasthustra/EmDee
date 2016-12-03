!   This file is part of EmDee.
!
!    EmDee is free software: you can redistribute it and/or modify
!    it under the terms of the GNU General Public License as published by
!    the Free Software Foundation, either version 3 of the License, or
!    (at your option) any later version.
!
!    EmDee is distributed in the hope that it will be useful,
!    but WITHOUT ANY WARRANTY; without even the implied warranty of
!    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
!    GNU General Public License for more details.
!
!    You should have received a copy of the GNU General Public License
!    along with EmDee. If not, see <http://www.gnu.org/licenses/>.
!
!    Author: Charlles R. A. Abreu (abreu@eq.ufrj.br)
!            Applied Thermodynamics and Molecular Simulation
!            Federal University of Rio de Janeiro, Brazil

module pair_coul_sf_module

use pairModelClass

!> Abstract class for pair model coul_sf
!! NOTE: all model parameters must be declared together as real(rb) in the first line
type, extends(cPairModel) :: pair_coul_sf
  contains
    procedure :: setup => pair_coul_sf_setup
    procedure :: compute => pair_coul_sf_compute
    procedure :: mix => pair_coul_sf_mix
end type pair_coul_sf

contains

!---------------------------------------------------------------------------------------------------

  subroutine pair_coul_sf_setup( model, params )
    class(pair_coul_sf), intent(inout) :: model
    real(rb),            intent(in)    :: params(:)

    ! Model name:
    model%name = "coul_sf"

    ! Activate shifted-force status:
    model%shifted_force_coul = .true.

  end subroutine pair_coul_sf_setup

!---------------------------------------------------------------------------------------------------

  subroutine pair_coul_sf_compute( model, Eij, Wij, invR2, Qi, Qj )
    class(pair_coul_sf), intent(in)  :: model
    real(rb),       intent(out) :: Eij, Wij
    real(rb),       intent(in)  :: invR2, Qi, Qj

    include "compute_pair_coul_sf.f90"

  end subroutine pair_coul_sf_compute

!---------------------------------------------------------------------------------------------------

  function pair_coul_sf_mix( this, other ) result( mixed )
    class(pair_coul_sf),    intent(in) :: this
    class(cPairModel), intent(in) :: other
    class(cPairModel), pointer :: mixed

    allocate(pair_coul_sf :: mixed)
    call mixed % setup( [zero] )

  end function pair_coul_sf_mix

!---------------------------------------------------------------------------------------------------

end module pair_coul_sf_module