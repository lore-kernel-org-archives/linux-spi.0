From: Michal Suchanek <hramrach@gmail.com>
Subject: Re: [PATCH 2/3] spi: of: allow instantiating slaves without a driver
Date: Sun, 26 Jun 2016 13:35:46 +0200
Message-ID: <CAOMqctQernycZkc0Wia9EierT1PhfcYAPWc=89LgTC-DBgkg5A@mail.gmail.com>
References: <cover.1466696079.git.hramrach@gmail.com> <ebe2a48124441819adab773b28cd12425ba5bda4.1466696079.git.hramrach@gmail.com>
 <20160626011500.GF28202@sirena.org.uk> <CAOMqctSA0G+fBKNgAizqWvEUfJLr9Fh0SsN0Pn-cQv=zeu7iFg@mail.gmail.com>
 <20160626112133.GJ28202@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ingo Molnar <mingo@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Kees Cook <keescook@chromium.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Dan Williams <dan.j.williams@intel.com>,
	Tejun Heo <tj@kernel.org>,
	"Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Andrey Ryabinin <aryabinin@virtuozzo.com>,
	Nikolay Aleksandrov <nikolay@cumulusnetworks.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Adrien Schildknecht <adrien+dev@schischi.me>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-spi <linux-spi@vger.kernel.org>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160626112133.GJ28202@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 26 June 2016 at 13:21, Mark Brown <broonie@kernel.org> wrote:
> On Sun, Jun 26, 2016 at 04:23:41AM +0200, Michal Suchanek wrote:
>> On 26 June 2016 at 03:15, Mark Brown <broonie@kernel.org> wrote:
>
>> > I can't relate this hunk to the changelog and there's a coding style
>> > problem, if there's { } on one side of an if statement it should be on
>> > both sides.  Why are we making this change?
>
>> The intention is that you can specify that your SPI master controller
>> has a CS available without setting up the slave
>
> This is completely unrelated to the rest of the change and needs
> describing in the changelog.
>
>> Then you can amend the slave node with an overlay or bind a driver
>> that can deal with the node having no configuration.
>
> You can just add the entire slave node in the overlay, it's not clear
> that this buys us anything useful

You have to target the master node and specify the CS in the overlay
if you create the whole node. If you target the slave node you have
the CS specified in the board devicetree and the overlay can apply to
multiple boards without change.

Also you have to create an overlay for drivers which don't really need
it and could be just manually bound.

> (and typically you'd want to as the
> maximum speed here is more a function of the slave device than the
> master),

Speed is the property of the slave device and if you don't specify the
device it does not make sense to specify speed.

> and this needs to be joined up with the work going on to allow
> expansion connector overlays to be loaded in the first place.

The overlays work equally well before and after this patch. I don't
see any problem with them other than part of the infrastructure
missing in mainline kernel.

>
>> The check here isn't very effective anyway since slaves with zero
>> speed somehow creep into the kernel. I have seen people reporting
>> division by zero in SPI master driver as a result. The proper way to
>> fix this is to specify the master minimum and maximum speed limit so
>> the SPI core can reject transfers with speed outside of the allowed
>> range.
>
> That's a separate argument which is again unrelated to the changelog.
> If the check isn't working it would be better to have an analysis of why
> it's not working.

My handwawing analysis is that it's probably due to the ability of
spidev and other drivers to change the speed later on after this check
is performed.

Anyway, it's not terribly useful so a warning suffices imho.

Thanks

Michal
