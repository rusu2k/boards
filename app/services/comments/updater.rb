class Comments::Updater
    include BaseUpdater

    def model
        Comment
    end
end