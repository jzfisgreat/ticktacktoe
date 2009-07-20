require 'rubygems'
require 'sinatra'

set :sessions, true

X='X'
O='O'

get '/' do
					
	session['rows'] ||= {}
	session['val'] ||= 0
	session['val'] +=  1

	if session['val'] % 2 == 0 
					@whoseturn=X
					@whoseturn1=O
						
	elsif	session['val'] % 2 == 1 
					@whoseturn=O
					@whoseturn1=X
	end


	session['rows'][params["coordinate"]] ||= @whoseturn
	
	@game=Game.new(session['rows'])
		
	
	

		@game.check

		@won=@game.won
		@winner=@game.winner


	erb :tictactoetest
end
get '/reset/' do 
			session['rows']={}

			redirect '/'
end


class Game
				attr_accessor :rows
				attr_accessor :won
				attr_accessor :winner
				def initialize(session)


								@rows=[nil,nil,nil],[nil,nil,nil],[nil,nil,nil]
		rows[0][0] = session['00']

		rows[0][1] = session['10']
	
		rows[0][2] = session['20']
	
		rows[1][0] = session['01']

		rows[1][1] = session['11']

		rows[1][2] = session['21']

		rows[2][0] = session['02']

		rows[2][1] = session['12']

		rows[2][2] = session['22']
		@won=false
						
				end


					def check_horizontals

					for i in @rows do 
						 if i[0] == i[1] && i[1] == i[2] && !i[0].nil?
										 @h=true
										 @won=true

								if i[0] == X && i[1] == X && i[2] == X
												@winner = X
								elsif i[0] == O && i[1] == O && i[2] == O
												@winner = O
						 end
						 end
				
					end
					
				end
				
				def check_verticals
								(0..2).each do |column|
									if @rows[0][column] == @rows[1][column] && @rows[1][column] == @rows[2][column] && !@rows[1][column.to_i].nil?
													if @rows[0][column] == X && @rows[1][column] == X && @rows[2][column] == X && !@rows[1][column.to_i].nil?
																	@winner = X
													elsif @rows[0][column] == O && @rows[1][column] == O && @rows[2][column] == O && !@rows[1][column.to_i].nil?
																	@winner = O
													end
				
										@won=true
										@v=true
									end

									end
				end


				
				def check_diagnols1
					(0..2).each do |diagnols|			
						if @rows[diagnols][diagnols] == @rows[0][0]   &&  @rows[diagnols][diagnols]== @rows[1][1] &&   @rows[diagnols][diagnols]==@rows[2][2] && !@rows[diagnols][diagnols].nil?
										if @rows[0][0] == X  &&  @rows[1][1] == X && @rows[2][2] == X && !@rows[diagnols][diagnols].nil?
														@winner = X
										elsif @rows[0][0] == O  &&  @rows[1][1] == O && @rows[2][2] == O && !@rows[diagnols][diagnols].nil?
														@winner = O
										end

									@won=true 
									@d=true
						end
					
					end
				end 
					def check_diagnols2
							[0,2].each do |x|
									y=2-x									
						
										if @rows[x][y]==@rows[1][1] &&  @rows[x][y]==@rows[2][0] && !@rows[x][y].nil? && !@rows[1][1].nil? && @rows[x][y]==@rows[0][2]
												if @rows[1][1] == X &&  @rows[2][0] == X && @rows[0][2] == X
																@winner = X
												elsif @rows[1][1] == O &&  @rows[2][0] == O && @rows[0][2] == O
																@winner = O

												end	
													@won=true	
													@d=true	
										end
							
								end
					end
				
			def winner?
						if @won == true
									if	@h == true
												@winner.to_s + ' has won horizontally'

									elsif @d == true
													@winner.to_s + '	has won won diagonally'
									elsif @v == true
												@winner.to_s + '	has won vertically'
									else
													'you win magically'
									end

						else 
													'Tie Game'
						end
			end
			def check
								check_horizontals
		
								check_verticals
		
								check_diagnols1
		
								check_diagnols2
			end
						
					end
