class User < ApplicationRecord
    has_secure_password
    validates :email, uniqueness: { case_sensitive: false }

    belongs_to :sun_sign

    def find_sun_sign
        birth_month = Date::MONTHNAMES[self.birthDate.split('-')[1].to_i]
        birth_day = self.birthDate.split('-')[2].to_i
        SunSign.all.select{|sign| (sign.sun_dates[0].split(' ')[0] === birth_month &&  sign.sun_dates[0].split(' ')[1].to_i <= birth_day) || (sign.sun_dates[1].split(' ')[0] === birth_month &&  sign.sun_dates[1].split(' ')[1].to_i > birth_day)}[0]
    end
end
