#@ creates an instance variable
# #{} is a way to write ruby code inside a string

#what does " include? " mean? & whats the term for it question mark operator I think
#what does nil mean? like null but not really? it's like an empty falsy value

#i wonder whats the bigO notation for this? (time complexity vs space complexity)

class Hangman

    def initialize
        #initialize method
        #creates array of letters
        # @letters = ('a'..'z').to_a  # not using this anymore


        #.. is a range? 'to_a' converts it to an array
        # making an array, bc once the user guesses that letter, 
        #we'll remove that letter from the options

        @word = words.sample
        # inclduing a limited # of guesses makes it more challenging
        # the # guesses are assigned to the instance variable called lives
        @lives = 7 

    #an instance variable to store correct guesses in an array
      #  @correct_guesses = []
        @word_teaser = ""

         #size method
        #.times method says to run the script x amt of times
        @word.first.size.times do
            @word_teaser += "_ "
        end
    end

    #method which returns an array of words
    #maybe import these from a seperate file
    #maybe sort these
    def words
        [
            ["basketball", "a game with a hoop"],        
            ["calisthenics", "graceful body movements"],        
            ["cricket", "a game not a bug"],        
            ["ballet", "body making lines to music"],        
            ["running", "rapid feet, not a car"],        
            ["yoga", "bendy"],        
        ]
    end

    #moved teaser into seperate method of its own, to keep it cleaner
    #then just call teaser method in the begin method
    def print_teaser last_guess = nil #nil default value
        # deleted this line below:
        # word_teaser = "", becuase word teaser is an instance method now


       #calls a new method called update teaser
       #passing in last_guess value 
       # only calls this value if the last guess value is not nil
        update_teaser(last_guess) unless last_guess.nil?
        puts @word_teaser
    end

    #update teaser method
    def update_teaser last_guess
        #splitting string based on the space between each underscore
        new_teaser = @word_teaser.split
#iterate over new teaser array
#each_with_index is a quick way to get a value 
# for each of the items
# in the array as we loop over them
        new_teaser.each_with_index do |letter, index|
         #replace blank value if guessed letter matches letter in word
            if letter == "_" && @word.first[index] == last_guess
                #update the underscore value with the letter
                new_teaser[index] = last_guess
            end
        end
        #override the instance variable for word_teaser with this new word_teaser value
        @word_teaser = new_teaser.join(' ')
    end



    def make_guess
    #if the user has enough lives
        if @lives > 0 
            puts "Enter a letter" #instructions for user
            #create new variable to capture input from user
            guess = gets.chomp
            #gets command takes the value from the terminal
            #chomp command removes line breaking
            # puts "You guessed #{guess}"
            #above is more of a debugger to track what the user guessed

            #if guess is correct remove guessed letter from letters array



            #include? checks the contents of the string 
            # to see if the string youre passing in 
            # is w/in that string - v confusing - ask abt this!
            # it returns a boolean
            # we assign that T/F value to the variable called good_guess
            good_guess = @word.first.include? guess 
            #if guess contains the word exit
            if guess == "1"
                puts "Thank you for playing!"
            
            #if guess is longer than 1 letter
            elsif guess.length > 1
                puts "only guess 1 letter at a time please!"
            make_guess
            
            #if guess is correct
            elsif good_guess 
                #display this message
                puts "Good guess! You are correct"

                # @correct_guesses << guess # not using this anymore

                #remove correct guess from alphabet
                #deletes that letter from the alphabet array
                # but array still includes all the other letters
                # @letters.delete guess  # not using this anymore

                print_teaser guess

                
                if @word.first == @word_teaser.split.join
                    puts "Congratulations... You won!"
                else
                    make_guess
                end
            else 
            #if guess is NOT correct
                @lives -= 1 
                #display this message - try again!
                puts "Sorry... You have #{ @lives } guesses left. Try again!"
                #also if they get it wrong, 
                #call method make_guess so they can try again 
                make_guess
            end
        #if the user is out of lives, the game ends
        else
            puts "Game Over... Better luck next time!"
        end
    end

#do all ruby projects have begin methods?
    def begin
        #called to start the game
        #asks user for a letter
        puts "New game has started... your word is #{ @word.first.size } characters long" 
        #allows user to exit game
        puts "To exit game at any point type '1'"
        print_teaser
        
        puts "Clue: #{ @word.last }"

        make_guess
        
    
        
    end
end

game = Hangman.new
game.begin