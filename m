From: Martin Sperl <martin-d5rIkyn9cnPYtjvyW6yDsg@public.gmane.org>
Subject: Re: Depreciated spi_master.transfer and "prepared spi messages" for an optimized pipelined-SPI-DMA-driver
Date: Wed, 30 Oct 2013 23:52:33 +0100
Message-ID: <3342FD19-4438-463B-89B2-A83D3475AC22@sperl.org>
References: <F70C4469-6325-48D5-A7CA-52CC1FC404BD@sperl.org> <CACRpkdb6y=o4__snBs2DR1f=xW_u7KdkHg3fb7XN5e2gicBJeg@mail.gmail.com> <CACRpkdb7y88oq7XyVFc_0Nx4pXtaebPe7KB2yizBRJGwWLqJig@mail.gmail.com> <06C7F4D3-EC91-46CF-90BE-FC24D54F2389@sperl.org> <02BFF0F6-3836-4DEC-AA53-FF100E037DE9@sperl.org> <20131030171902.GL2493@sirena.org.uk> <8D8B0BAD-0E00-4147-B4C8-FBB18F060C96@sperl.org> <20131030215716.GV2493@sirena.org.uk>
Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20131030215716.GV2493-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Mark!

After a lot of digging I found the API you are referring to in:
http://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git/tree/include/linux/spi/spi.h

So when will this go in?

How would you recommend to connect your prepared structure to a specific  message?
There is no flag/field in spi_message to link that.

Would this mean that I would keep an internal list with the address of the SPI message 
any my "prepared data" and I need to iterate over that list every time I need it?
This search might - worsted case - become a scaling issue if too many prepared 
statements are created... 
Ok, there are other constructs to store data in making lookup faster,
but does this not make the driver more complex than necessary?

It could lead to all drivers starting "simple" and then at some point it becomes
an issue as one driver makes heavy use of this showing it becomes a bottle-neck
and then all spi-bus-drivers would need to get touched to optimize things...

Why not provide a lookup function for the prepared data immediately and make 
sure the drivers use this one. Then we only have to change it later in one place
and reduce code-replication across drivers.
(obviously you would also need put/delete methods to make that interface complete.)

Also those function pointers do not have wrappers functions for ease of use, 
so that they can get used in the individual drivers that know that they can 
prepare the spi_message, as they do not change the transfer structure....

Thanks,
		Martin

On 30.10.2013, at 22:57, Mark Brown wrote:

> On Wed, Oct 30, 2013 at 07:33:30PM +0100, Martin Sperl wrote:
> 
>> I have seen your email and I have checked 3.12-rc7:
>> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/include/linux/spi/spi.h?id=refs/tags/v3.12-rc7
>> (Assuming this is the latest, but I would say that the version of Linus would 
>> be authoritative)
> 
> No, look in -next (or the SPI tree which you can see in MAINTAINERS):
> 
>  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git
> 
>> The following would go into struct spi_master:
>>  int (*prepare_message)(struct spi_device *dev,struct spi_message *mesg);
>>  int (*unprepare_message)(struct spi_device *dev,struct spi_message *mesg);
> 
> Which, like I say, is exactly what's there in terms of a driver API.

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
