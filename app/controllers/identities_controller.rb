#
# The IdentitiesController is the CRUD Interface to the Identities Table.
#
# This controller is somewhat miimal,as it only needs to handle the registration of a new user
class IdentitiesController < ApplicationController

  # The new action nnly needs to re-populate the identitiy form in the case of an error with the original registration
  # process
  def new
    @identity = env['omniauth.identity']
  end

end
