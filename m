From: Michal Suchanek <hramrach@gmail.com>
Subject: Re: [PATCH v2 3/3] drivers core: allow id match override when
 manually binding driver
Date: Tue, 28 Jun 2016 22:02:59 +0200
Message-ID: <CAOMqctTNmcg32PFVOZaA99GpFba9GOGOuOqmi3ujzxcHRFZsOA@mail.gmail.com>
References: <cover.1467053363.git.hramrach@gmail.com> <15ff382f699387e2d8f23779db851d0de7e9291e.1467053363.git.hramrach@gmail.com>
 <20160627190949.GB5111@kroah.com> <CAOMqctQj0ftbOH9dvMPczBPeSFTvDuTKCXgYprYvtcQDYML8Kw@mail.gmail.com>
 <20160627221259.GA10054@kroah.com> <CAOMqctTQAY0NzTpEqyLyScu8UrSXcF82oLVMM+e2F2WQ225B7A@mail.gmail.com>
 <20160628155107.GP17217@sirena.org.uk> <CAOMqctQbFmWv04idz7G+dPOCg7n-E0AQdhGAyohUDBniKvrP_g@mail.gmail.com>
 <20160628183825.GS17217@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-spi <linux-spi@vger.kernel.org>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160628183825.GS17217@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 28 June 2016 at 20:38, Mark Brown <broonie@kernel.org> wrote:
> On Tue, Jun 28, 2016 at 06:24:58PM +0200, Michal Suchanek wrote:
>
>> No, no, no!
>
>> This is NOT about loading an overlay. This is about talking on the bus
>> without loading an overlay.
>
> This is the solution you want to adopt because you've decided that it's
> what you want.  You've said this quite a number of times now.
>
>> > Repeating yourself over and over again is not going to help here, it's
>> > just going to make people more annoyed.  Please stop this.
>
>> Then please add something constructive to the debate rather than
>> repeating that users have to add compatible for devices used with
>> userspace driver. That's ridiculous from usability point of view and
>> so will never happen. At best workarounds for kernel obtuseness will
>> be used.
>
> It would take a lot less effort for you to just describe your hardware
> in DT than it would for you to continue repeating yourself, this is a
> trivial task.

It would be less work having a mainline solution but whatever.

Of course I could add "my-shiny-new-board" compatible to the device
tree and spidev. Then when I build my-shiny-new-board2 and it happens
to also use userspace driver I will not bother to update the
compatible nor will anyone else doing this. So it's equivalent to
having "foobar123" in there from the start. Your proposed solution is
so complex that it will never be used as intended even if changing the
compatible on the node and driver could be both accomplished by an
echo to sysfs.

>  If the tooling around this is too hard to use then that
> seems like a useful thing to work on, having simple ways for people to
> describe modules they build for maker type systems (ideally integrated
> with schematic capture software) would be great for example.

Again, what simple to use tooling do you use to describe the modem you
connect to a serial port in the kernel (ideally integrated with
schematic capture software)? I use none. I just connect the modem. I
want to do that with all SPI devices that I do not intend to use with
an in-kernel driver above the spi master driver that provides the
communication channel as is the case with the serial modem.

>
> Both Greg and myself have provided you with feedback which you appear to
> be ignoring entirely.  What you are demanding is not idiomatic for DT or
> for the device model, this needs to be taken on board rather than just
> shouting at us.  Putting a quick hack in that happens to work for your
> very specific use case isn't going to give us a consistent, maintainable
> and well designed system if it doesn't fit with anything else we're
> doing.

It is not my very specific use case. It's common use case for
devboards which have spi connectors.

If this particular way to solve the problem does not fit with the
driver model does any of the previously listed ones fit better,
perhaps with some changes?

Or since you are familiar with the driver model perhaps you are away
of a solution that was not mentioned so far that would accomplish this
and fits with the driver model?

Or if this use case does not fit into the driver model at all then
perhaps the driver model needs updating to catch up with real world?

Thanks

Michal
