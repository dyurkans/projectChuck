module ApplicationHelper

    def team_name(team_id)
        index_of_team_id = 1
        Team::FULL_TEAM_LIST.map{|t| t[0] if t[index_of_team_id]==team_id }.compact[0]
    end

end
