From: Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/3] spidev: Add DT binding example.
Date: Tue, 12 May 2015 16:52:00 +0200
Message-ID: <CAOMqctSe+us_3GfaR3FLeP0tv-pfYsXSawnL9cTSOTgVyPf2bw@mail.gmail.com>
References: <20150426103257.GJ22845@sirena.org.uk> <CAOMqctR235uF+7kNGsLEGfrrAOQAYmw0pWgk6t8fZHNT7XsRuw@mail.gmail.com>
 <20150426110144.GK22845@sirena.org.uk> <553CCABA.3090504@redhat.com>
 <12F80B18-7418-430E-94F7-5A20C133BA9A@martin.sperl.org> <CAOMqctR8MZ_r6HHEBWhgxpUsTaV=M7DfmnJ_VxTqjWu4KMBSwA@mail.gmail.com>
 <20150426125113.GF5627@lukather> <20150427101601.GN22845@sirena.org.uk>
 <20150427173036.GA10950@lukather> <20150427180728.GW22845@sirena.org.uk> <20150512142759.GK10961@lukather>
Reply-To: hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>,
	Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
	Jonathan Corbet <corbet-T1hC0tSOHrs@public.gmane.org>, linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	linux-doc <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Return-path: <linux-sunxi+bncBCQMLUOX54MBBONHZCVAKGQEEA6ZV3I-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <20150512142759.GK10961@lukather>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <http://groups.google.com/group/linux-sunxi/subscribe>
List-Id: linux-spi.vger.kernel.org

Hello,

On 12 May 2015 at 16:27, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org> wrote:
> On Mon, Apr 27, 2015 at 07:07:28PM +0100, Mark Brown wrote:
>> On Mon, Apr 27, 2015 at 07:30:36PM +0200, Maxime Ripard wrote:
>> > On Mon, Apr 27, 2015 at 11:16:01AM +0100, Mark Brown wrote:
>>
>> > > lkml.org is being terrible as usual so I can't see half the thread (or
>> > > at least got fed up trying to get it to load)
>>
>> > A part of it is also here:
>> > http://lkml.iu.edu/hypermail/linux/kernel/1405.0/00484.html
>>
>> OK, thanks.
>>
>> > > but I think the discussion there petered out more than anything
>> > > else.
>>
>> > Maybe it did :)
>>
>> I think so looking at the archives.
>>
>> > > Or was it the suggestion to make this something that the driver core
>> > > supported so that we didn't have to open code it for every bus?
>>
>> > Probably. That's something I really haven't took the time to look at,
>> > and don't really plan on doing so.
>>
>> > I guess a good way forward would be to revive this patch, and wait for
>> > that generic way to happen.
>>
>> > What do you think of this?
>>
>> Probably best, the Pi bootloader does make it a bit more important.
>> Might also be worth speaking to Greg though.
>
> So, do you want me to resend that patch and discuss this directly
> there (with Greg in Cc) ?

My general idea is to get overlay loading to work and then make spidev
bind to all CS which are not taken by anything and unbind when an
overlay tries to take over the CS. Since there are some overlay
loading patches available that part can be considered solved but I did
not get to looking at the dynamic spidev binding.

For now I use your patch with additional patch that marks the spidev
devices with a flag so they are not checked when it is determined if
the CS is in use.

Thanks

Michal
