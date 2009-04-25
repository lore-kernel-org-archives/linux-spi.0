From: Bryan Wu <cooloney-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: General SPI question
Date: Sat, 25 Apr 2009 12:57:04 +0800
Message-ID: <386072610904242157h6c7dc7e8qf6e66ec4e0057423@mail.gmail.com>
References: <8ee9e87c0904232328j7f912eb6v3d0b9cb0321793a9@mail.gmail.com>
	<200904240031.53343.david-b@pacbell.net>
	<8ee9e87c0904240128y1615625aiae9468de0a02643@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Arnav Das <arnavdas29-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <8ee9e87c0904240128y1615625aiae9468de0a02643-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Fri, Apr 24, 2009 at 4:28 PM, Arnav Das <arnavdas29-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> thanks for the quick reply.
>
> i basically want to make a cro out of the adc and the beaglebard. so
> whatever input i get, i need to show it in a graphical manner on a real t=
ime
> basis. this probably can be forthur utilised in as a ecg in medical
> applications and further improvements can be made.
>
> could you please guide me to a knowledgebase from where i can learn all
> about spi, drivers and spi drivers(platform independant, if possible) as =
my
> main focus of the project is the graphical part wherein i will use the da=
ta
> collected to output on the screen with proper gui.
>
> i got this adc driver from blackfin/uclinux resources please see whether =
it
> is ok?
>

This blackfin spi adc driver will never go to upstream mainline,
because it is a old implementation for some legacy customer product.
Please follow Dave's suggestion.

Thanks
-Bryan

> Thanks a lot,
> Arnav
>
> On Fri, Apr 24, 2009 at 1:01 PM, David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org> wro=
te:
>>
>> [ I dropped the PPC folk from the cc list.. ]
>>
>> On Thursday 23 April 2009, Arnav Das wrote:
>> > Hi,
>> >
>> > Thanks a lot and sorry for the mistakes. I have gone through the trm of
>> > the
>> > adc as well as the omap driver. my question is that i want to interact
>> > the
>> > adc to the board. now should i directly use the omap driver or should i
>> > mak
>> > one of my own.
>>
>> Unless you have a compelling reason, use the OMAP controller driver.
>>
>> You'd write a spi_driver -- a *REALLY* simple one -- using interfaces
>> described in Documentation/spi/spi-summary for the lower level. =A0Almost
>> all the work involved would be in the upper level interface: =A0presenti=
ng
>> the data to whatever needs it. =A0Maybe sysfs, maybe not; you've not said
>> anything about how you need to use this data. =A0That would usually be
>> the first thing to figure out...
>>
>>
>> > if i make one of my own then i would like to know how would
>> > the spi registers be changed by driver. should it include the omap2
>> > driver
>> > or is the fuctionality provided directly when i include spi.h.
>>
>> You should end up with a simple ADC driver that can hook up to
>> any platform's SPI controller. =A0Your driver will talk to a
>> "struct spi_device" and will be usable on non-OMAP boards.
>>
>>
>> > another doubt: when and why is the spidev.c/h used?
>>
>> When you want a "userspace driver" instead of a kernel driver.
>>
>> - Dave
>>
>>
>> > i am deeply grateful towards you for helping me out
>> > thanks
>> > Arnav
>> >
>> > On Fri, Apr 24, 2009 at 11:50 AM, David Brownell
>> > <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>wrote:
>> >
>> > > On Thursday 23 April 2009, Arnav Das wrote:
>> > > > i am a newbie
>> > >
>> > > Lesson #1: =A0make sure your Subject: lines match the message
>> > > topic (I did a partial repair) and don't post to the wrong
>> > > list (e.g. PPC lists for OMAP questions).
>> > >
>> > >
>> > > > and am doing a project on beagle board(running
>> > > > omap3530). i am interfacing an adc(ads7886) to the beagleboard via
>> > > > spi. need to know how the spi works
>> > >
>> > > Read the ads7886 data sheet, in this case. =A0It uses
>> > > a subset of SPI ... no input commands, just a 12-bit
>> > > sample returned each time chipselect pulses.
>> > >
>> > >
>> > > > and how a module can access the
>> > > > spi registers of the omap. if someones already made an adc driver
>> > > > can
>> > > > they mail me?
>> > >
>> > > Use drivers/spi/omap2_mcspi.c on OMAP3 boards, at
>> > > least to start with. =A0If you want streaming conversions
>> > > you may want to use different modes than are currently
>> > > supported by that driver.
>> > >
>> > > - Dave
>> > >
>> > >
>> > >
>> > >
>> > >
>> >
>>
>>
>
>
> -------------------------------------------------------------------------=
-----
> Crystal Reports &#45; New Free Runtime and 30 Day Trial
> Check out the new simplified licensign option that enables unlimited
> royalty&#45;free distribution of the report engine for externally facing
> server and web deployment.
> http://p.sf.net/sfu/businessobjects
> _______________________________________________
> spi-devel-general mailing list
> spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/spi-devel-general
>
>

---------------------------------------------------------------------------=
---
Crystal Reports &#45; New Free Runtime and 30 Day Trial
Check out the new simplified licensign option that enables unlimited
royalty&#45;free distribution of the report engine for externally facing =

server and web deployment.
http://p.sf.net/sfu/businessobjects
