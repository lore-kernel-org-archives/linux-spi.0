From: Arnav Das <arnavdas29-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: General SPI question
Date: Mon, 27 Apr 2009 12:20:18 +0530
Message-ID: <8ee9e87c0904262350h7be253abxd8bc7f11880dd85a@mail.gmail.com>
References: <8ee9e87c0904232328j7f912eb6v3d0b9cb0321793a9@mail.gmail.com>
	<200904240031.53343.david-b@pacbell.net>
	<8ee9e87c0904240128y1615625aiae9468de0a02643@mail.gmail.com>
	<386072610904242157h6c7dc7e8qf6e66ec4e0057423@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5785130176311901445=="
Cc: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Bryan Wu <cooloney-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <386072610904242157h6c7dc7e8qf6e66ec4e0057423-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

--===============5785130176311901445==
Content-Type: multipart/alternative; boundary=001636284f226ea360046883c214

--001636284f226ea360046883c214
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi,

Thanks for looking at the blackfin driver. But i dont wanna use the driver
as it is. since my major work is in making the user level application rather
than the driver i was asking whether this driver could be modified for the
omap330-ads7886 combo. also if you could help me writing the driver fully
that would be a very helpful and would be highly grateful for it. please
help

thanks
Arnav
On Sat, Apr 25, 2009 at 10:27 AM, Bryan Wu <cooloney-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:

> On Fri, Apr 24, 2009 at 4:28 PM, Arnav Das <arnavdas29-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> > thanks for the quick reply.
> >
> > i basically want to make a cro out of the adc and the beaglebard. so
> > whatever input i get, i need to show it in a graphical manner on a real
> time
> > basis. this probably can be forthur utilised in as a ecg in medical
> > applications and further improvements can be made.
> >
> > could you please guide me to a knowledgebase from where i can learn all
> > about spi, drivers and spi drivers(platform independant, if possible) as
> my
> > main focus of the project is the graphical part wherein i will use the
> data
> > collected to output on the screen with proper gui.
> >
> > i got this adc driver from blackfin/uclinux resources please see whether
> it
> > is ok?
> >
>
> This blackfin spi adc driver will never go to upstream mainline,
> because it is a old implementation for some legacy customer product.
> Please follow Dave's suggestion.
>
> Thanks
> -Bryan
>
> > Thanks a lot,
> > Arnav
> >
> > On Fri, Apr 24, 2009 at 1:01 PM, David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
> wrote:
> >>
> >> [ I dropped the PPC folk from the cc list.. ]
> >>
> >> On Thursday 23 April 2009, Arnav Das wrote:
> >> > Hi,
> >> >
> >> > Thanks a lot and sorry for the mistakes. I have gone through the trm
> of
> >> > the
> >> > adc as well as the omap driver. my question is that i want to interact
> >> > the
> >> > adc to the board. now should i directly use the omap driver or should
> i
> >> > mak
> >> > one of my own.
> >>
> >> Unless you have a compelling reason, use the OMAP controller driver.
> >>
> >> You'd write a spi_driver -- a *REALLY* simple one -- using interfaces
> >> described in Documentation/spi/spi-summary for the lower level.  Almost
> >> all the work involved would be in the upper level interface:  presenting
> >> the data to whatever needs it.  Maybe sysfs, maybe not; you've not said
> >> anything about how you need to use this data.  That would usually be
> >> the first thing to figure out...
> >>
> >>
> >> > if i make one of my own then i would like to know how would
> >> > the spi registers be changed by driver. should it include the omap2
> >> > driver
> >> > or is the fuctionality provided directly when i include spi.h.
> >>
> >> You should end up with a simple ADC driver that can hook up to
> >> any platform's SPI controller.  Your driver will talk to a
> >> "struct spi_device" and will be usable on non-OMAP boards.
> >>
> >>
> >> > another doubt: when and why is the spidev.c/h used?
> >>
> >> When you want a "userspace driver" instead of a kernel driver.
> >>
> >> - Dave
> >>
> >>
> >> > i am deeply grateful towards you for helping me out
> >> > thanks
> >> > Arnav
> >> >
> >> > On Fri, Apr 24, 2009 at 11:50 AM, David Brownell
> >> > <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>wrote:
> >> >
> >> > > On Thursday 23 April 2009, Arnav Das wrote:
> >> > > > i am a newbie
> >> > >
> >> > > Lesson #1:  make sure your Subject: lines match the message
> >> > > topic (I did a partial repair) and don't post to the wrong
> >> > > list (e.g. PPC lists for OMAP questions).
> >> > >
> >> > >
> >> > > > and am doing a project on beagle board(running
> >> > > > omap3530). i am interfacing an adc(ads7886) to the beagleboard via
> >> > > > spi. need to know how the spi works
> >> > >
> >> > > Read the ads7886 data sheet, in this case.  It uses
> >> > > a subset of SPI ... no input commands, just a 12-bit
> >> > > sample returned each time chipselect pulses.
> >> > >
> >> > >
> >> > > > and how a module can access the
> >> > > > spi registers of the omap. if someones already made an adc driver
> >> > > > can
> >> > > > they mail me?
> >> > >
> >> > > Use drivers/spi/omap2_mcspi.c on OMAP3 boards, at
> >> > > least to start with.  If you want streaming conversions
> >> > > you may want to use different modes than are currently
> >> > > supported by that driver.
> >> > >
> >> > > - Dave
> >> > >
> >> > >
> >> > >
> >> > >
> >> > >
> >> >
> >>
> >>
> >
> >
> >
> ------------------------------------------------------------------------------
> > Crystal Reports &#45; New Free Runtime and 30 Day Trial
> > Check out the new simplified licensign option that enables unlimited
> > royalty&#45;free distribution of the report engine for externally facing
> > server and web deployment.
> > http://p.sf.net/sfu/businessobjects
> > _______________________________________________
> > spi-devel-general mailing list
> > spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> > https://lists.sourceforge.net/lists/listinfo/spi-devel-general
> >
> >
>

--001636284f226ea360046883c214
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div>Hi,</div>
<div>=A0</div>
<div>Thanks for looking at the blackfin driver. But i dont wanna use the dr=
iver as it is. since my major work is in making the user level application =
rather than the driver i was asking whether this driver could be modified f=
or the omap330-ads7886 combo. also if you could help me writing the driver =
fully that would be a very helpful and would be highly grateful for it. ple=
ase help</div>

<div>=A0</div>
<div>thanks</div>
<div>Arnav<br></div>
<div class=3D"gmail_quote">On Sat, Apr 25, 2009 at 10:27 AM, Bryan Wu <span=
 dir=3D"ltr">&lt;<a href=3D"mailto:cooloney-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org">cooloney-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org=
</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"PADDING-LEFT: 1ex; MARGIN: 0px 0=
px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">
<div class=3D"im">On Fri, Apr 24, 2009 at 4:28 PM, Arnav Das &lt;<a href=3D=
"mailto:arnavdas29-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">arnavdas29-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt; wrote:<br>&gt; t=
hanks for the quick reply.<br>&gt;<br>&gt; i basically want to make a cro o=
ut of the adc and the beaglebard. so<br>
&gt; whatever input i get, i need to show it in a graphical manner on a rea=
l time<br>&gt; basis. this probably can be forthur utilised in as a ecg in =
medical<br>&gt; applications and further improvements can be made.<br>&gt;<=
br>
&gt; could you please guide me to a knowledgebase from where i can learn al=
l<br>&gt; about spi, drivers and spi drivers(platform independant, if possi=
ble) as my<br>&gt; main focus of the project is the graphical part wherein =
i will use the data<br>
&gt; collected to output on the screen with proper gui.<br>&gt;<br>&gt; i g=
ot this adc driver from blackfin/uclinux resources please see whether it<br=
>&gt; is ok?<br>&gt;<br><br></div>This blackfin spi adc driver will never g=
o to upstream mainline,<br>
because it is a old implementation for some legacy customer product.<br>Ple=
ase follow Dave&#39;s suggestion.<br><br>Thanks<br>-Bryan<br>
<div>
<div></div>
<div class=3D"h5"><br>&gt; Thanks a lot,<br>&gt; Arnav<br>&gt;<br>&gt; On F=
ri, Apr 24, 2009 at 1:01 PM, David Brownell &lt;<a href=3D"mailto:david-b@p=
acbell.net">david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org</a>&gt; wrote:<br>&gt;&gt;<br>&gt;&gt; [ I =
dropped the PPC folk from the cc list.. ]<br>
&gt;&gt;<br>&gt;&gt; On Thursday 23 April 2009, Arnav Das wrote:<br>&gt;&gt=
; &gt; Hi,<br>&gt;&gt; &gt;<br>&gt;&gt; &gt; Thanks a lot and sorry for the=
 mistakes. I have gone through the trm of<br>&gt;&gt; &gt; the<br>&gt;&gt; =
&gt; adc as well as the omap driver. my question is that i want to interact=
<br>
&gt;&gt; &gt; the<br>&gt;&gt; &gt; adc to the board. now should i directly =
use the omap driver or should i<br>&gt;&gt; &gt; mak<br>&gt;&gt; &gt; one o=
f my own.<br>&gt;&gt;<br>&gt;&gt; Unless you have a compelling reason, use =
the OMAP controller driver.<br>
&gt;&gt;<br>&gt;&gt; You&#39;d write a spi_driver -- a *REALLY* simple one =
-- using interfaces<br>&gt;&gt; described in Documentation/spi/spi-summary =
for the lower level. =A0Almost<br>&gt;&gt; all the work involved would be i=
n the upper level interface: =A0presenting<br>
&gt;&gt; the data to whatever needs it. =A0Maybe sysfs, maybe not; you&#39;=
ve not said<br>&gt;&gt; anything about how you need to use this data. =A0Th=
at would usually be<br>&gt;&gt; the first thing to figure out...<br>&gt;&gt=
;<br>
&gt;&gt;<br>&gt;&gt; &gt; if i make one of my own then i would like to know=
 how would<br>&gt;&gt; &gt; the spi registers be changed by driver. should =
it include the omap2<br>&gt;&gt; &gt; driver<br>&gt;&gt; &gt; or is the fuc=
tionality provided directly when i include spi.h.<br>
&gt;&gt;<br>&gt;&gt; You should end up with a simple ADC driver that can ho=
ok up to<br>&gt;&gt; any platform&#39;s SPI controller. =A0Your driver will=
 talk to a<br>&gt;&gt; &quot;struct spi_device&quot; and will be usable on =
non-OMAP boards.<br>
&gt;&gt;<br>&gt;&gt;<br>&gt;&gt; &gt; another doubt: when and why is the sp=
idev.c/h used?<br>&gt;&gt;<br>&gt;&gt; When you want a &quot;userspace driv=
er&quot; instead of a kernel driver.<br>&gt;&gt;<br>&gt;&gt; - Dave<br>
&gt;&gt;<br>&gt;&gt;<br>&gt;&gt; &gt; i am deeply grateful towards you for =
helping me out<br>&gt;&gt; &gt; thanks<br>&gt;&gt; &gt; Arnav<br>&gt;&gt; &=
gt;<br>&gt;&gt; &gt; On Fri, Apr 24, 2009 at 11:50 AM, David Brownell<br>
&gt;&gt; &gt; &lt;<a href=3D"mailto:david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org">david-b-yBeKhBN/0LBNg+MwTxZMZA@public.gmane.org=
t</a>&gt;wrote:<br>&gt;&gt; &gt;<br>&gt;&gt; &gt; &gt; On Thursday 23 April=
 2009, Arnav Das wrote:<br>&gt;&gt; &gt; &gt; &gt; i am a newbie<br>&gt;&gt=
; &gt; &gt;<br>
&gt;&gt; &gt; &gt; Lesson #1: =A0make sure your Subject: lines match the me=
ssage<br>&gt;&gt; &gt; &gt; topic (I did a partial repair) and don&#39;t po=
st to the wrong<br>&gt;&gt; &gt; &gt; list (e.g. PPC lists for OMAP questio=
ns).<br>
&gt;&gt; &gt; &gt;<br>&gt;&gt; &gt; &gt;<br>&gt;&gt; &gt; &gt; &gt; and am =
doing a project on beagle board(running<br>&gt;&gt; &gt; &gt; &gt; omap3530=
). i am interfacing an adc(ads7886) to the beagleboard via<br>&gt;&gt; &gt;=
 &gt; &gt; spi. need to know how the spi works<br>
&gt;&gt; &gt; &gt;<br>&gt;&gt; &gt; &gt; Read the ads7886 data sheet, in th=
is case. =A0It uses<br>&gt;&gt; &gt; &gt; a subset of SPI ... no input comm=
ands, just a 12-bit<br>&gt;&gt; &gt; &gt; sample returned each time chipsel=
ect pulses.<br>
&gt;&gt; &gt; &gt;<br>&gt;&gt; &gt; &gt;<br>&gt;&gt; &gt; &gt; &gt; and how=
 a module can access the<br>&gt;&gt; &gt; &gt; &gt; spi registers of the om=
ap. if someones already made an adc driver<br>&gt;&gt; &gt; &gt; &gt; can<b=
r>
&gt;&gt; &gt; &gt; &gt; they mail me?<br>&gt;&gt; &gt; &gt;<br>&gt;&gt; &gt=
; &gt; Use drivers/spi/omap2_mcspi.c on OMAP3 boards, at<br>&gt;&gt; &gt; &=
gt; least to start with. =A0If you want streaming conversions<br>&gt;&gt; &=
gt; &gt; you may want to use different modes than are currently<br>
&gt;&gt; &gt; &gt; supported by that driver.<br>&gt;&gt; &gt; &gt;<br>&gt;&=
gt; &gt; &gt; - Dave<br>&gt;&gt; &gt; &gt;<br>&gt;&gt; &gt; &gt;<br>&gt;&gt=
; &gt; &gt;<br>&gt;&gt; &gt; &gt;<br>&gt;&gt; &gt; &gt;<br>&gt;&gt; &gt;<br=
>
&gt;&gt;<br>&gt;&gt;<br>&gt;<br>&gt;<br></div></div>&gt; ------------------=
------------------------------------------------------------<br>&gt; Crysta=
l Reports &amp;#45; New Free Runtime and 30 Day Trial<br>&gt; Check out the=
 new simplified licensign option that enables unlimited<br>
&gt; royalty&amp;#45;free distribution of the report engine for externally =
facing<br>&gt; server and web deployment.<br>&gt; <a href=3D"http://p.sf.ne=
t/sfu/businessobjects" target=3D"_blank">http://p.sf.net/sfu/businessobject=
s</a><br>
&gt; _______________________________________________<br>&gt; spi-devel-gene=
ral mailing list<br>&gt; <a href=3D"mailto:spi-devel-general-5NWGOfrQmnetEtDZOKyKiw@public.gmane.org=
rge.net">spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org</a><br>&gt; <a href=3D"htt=
ps://lists.sourceforge.net/lists/listinfo/spi-devel-general" target=3D"_bla=
nk">https://lists.sourceforge.net/lists/listinfo/spi-devel-general</a><br>
&gt;<br>&gt;<br></blockquote></div><br>

--001636284f226ea360046883c214--


--===============5785130176311901445==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Crystal Reports &#45; New Free Runtime and 30 Day Trial
Check out the new simplified licensign option that enables unlimited
royalty&#45;free distribution of the report engine for externally facing 
server and web deployment.
http://p.sf.net/sfu/businessobjects
--===============5785130176311901445==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
spi-devel-general mailing list
spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
https://lists.sourceforge.net/lists/listinfo/spi-devel-general

--===============5785130176311901445==--
