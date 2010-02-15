From: arjun rath <rath.arjun-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: spi-devel-general Digest, Vol 45, Issue 15
Date: Mon, 15 Feb 2010 12:03:20 +0530
Message-ID: <dc6d3181002142233k794324cdi17a1d8befc99c49c@mail.gmail.com>
References: <mailman.10314.1266085937.4911.spi-devel-general@lists.sourceforge.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3340511686250381002=="
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <mailman.10314.1266085937.4911.spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

--===============3340511686250381002==
Content-Type: multipart/alternative; boundary=0016e64caef2169a54047f9dcbc6

--0016e64caef2169a54047f9dcbc6
Content-Type: text/plain; charset=ISO-8859-1

Hi all,

Thanks to all for the suggestions.

But whatever driver for ADC i am getting is through I2C connected only.Like
any other spi slave driver,i added for my spi device also and the device is
opening also.But now i am trying how to read the data which i am not
getting.



On Sun, Feb 14, 2010 at 12:02 AM, <
spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org> wrote:

> Send spi-devel-general mailing list submissions to
>        spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>
> To subscribe or unsubscribe via the World Wide Web, visit
>        https://lists.sourceforge.net/lists/listinfo/spi-devel-general
> or, via email, send a message with subject or body 'help' to
>        spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>
> You can reach the person managing the list at
>        spi-devel-general-owner-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>
> When replying, please edit your Subject line so it is more specific
> than "Re: Contents of spi-devel-general digest..."
>
>
> Today's Topics:
>
>   1. SPI-ADC (arjun rath)
>   2. Re: SPI-ADC (Ben Gamari)
>   3. Re: SPI-ADC (Linus Walleij)
>   4. [SPAM] ???????????????? ??????????? ?????
>      ( ??????????????? ???????? )
>   5. Re: SPI-ADC (Jonathan Cameron)
>   6. Re: SPI-ADC (Mike Frysinger)
>   7. [SPAM] Offert : notre guide pour mieux gerer      votre epargne et
>      developper votre patrimoine (Immo-web)
>
>
> ----------------------------------------------------------------------
>
> Message: 1
> Date: Sat, 13 Feb 2010 11:18:40 +0530
> From: arjun rath <rath.arjun-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Subject: [spi-devel-general] SPI-ADC
> To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> Message-ID:
>        <dc6d3181002122148v6451ebffka164de288738485d-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
> Content-Type: text/plain; charset="iso-8859-1"
>
> Hi everybody,
>
> can anybody share how to start a spi based ADC linux driver.I am having a
> MAXIM 1242 ADC chip.
>
> Can anybody share some reference driver for the same chip
>
> Thanks in advance
>
> Arjun
> -------------- next part --------------
> An HTML attachment was scrubbed...
>
> ------------------------------
>
> Message: 2
> Date: Sat, 13 Feb 2010 01:38:16 -0500
> From: Ben Gamari <bgamari-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Subject: Re: [spi-devel-general] SPI-ADC
> To: spi-devel-general <spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
> Message-ID: <1266042736-sup-3579@ben-laptop>
> Content-Type: text/plain; charset=UTF-8
>
> Excerpts from arjun rath's message of Sat Feb 13 00:48:40 -0500 2010:
> > Hi everybody,
> >
> > can anybody share how to start a spi based ADC linux driver.I am having a
> > MAXIM 1242 ADC chip.
> >
> > Can anybody share some reference driver for the same chip
> >
> I've recently been working on a design for a data acquisition
> board to interface with the Beagle Board using the Maxim 5134 and 1270.
> I'm using the spidev driver to interface with the devices from
> user-space. Documentation on this driver can be found in the
> Documentation/spi/spidev file of the Linux kernel tree. My code can be
> found at [1]. Hope things are going well,
>
> - Ben
>
>
> [1] http://goldnerlab.physics.umass.edu/git?p=tracker.git;a=tree
>
>
>
> ------------------------------
>
> Message: 3
> Date: Sat, 13 Feb 2010 14:48:22 +0100
> From: Linus Walleij <linus.ml.walleij-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Subject: Re: [spi-devel-general] SPI-ADC
> To: arjun rath <rath.arjun-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,    linux kernel
>        <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
> Message-ID:
>        <63386a3d1002130548y7c839072y85097a9bcdf66cad-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
> Content-Type: text/plain; charset=UTF-8
>
> 2010/2/13 arjun rath <rath.arjun-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>:
>
> > can anybody share how to start a spi based ADC linux driver.I am having a
> > MAXIM 1242 ADC chip.
>
> The ?ernel does not contain any generic ADC subsystem abstraction (I
> think it would be good if it did), instead most drivers using ADC have
> their ADC portions stored inside a driver for something else, e.g.
> drivers/hwmon for ADCs used in temperature monitoring, or
> drivers/power for ADCs used in monitoring of currents and voltages
> for power supplies/batteries.
>
> This is a bit bad for driving a generic ADC like this using spidev and,
> even if it was to be accessed from userspace only, having it under
> drivers/spi is rather counterintuitive, what happens when the next ADC
> using I2C turns up? drivers/i2c/chips?
>
> I would suggest creating subsystem drivers/adc if you have time and
> energy, other ideas?
>
> Linus Walleij
>
>
>
> ------------------------------
>
> Message: 4
> Date: Sat, 13 Feb 2010 18:18:04 +0300
> From: " ??????????????? ???????? "      <debywepocehugaly-oe7qfRrRQfd4OK5fxMSSsQ@public.gmane.org>
> Subject: [spi-devel-general] [SPAM] ???????????????? ??????????? ?????
> To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> Message-ID: <1162144242.20100213181804-oe7qfRrRQfd4OK5fxMSSsQ@public.gmane.org>
> Content-Type: text/plain; charset="utf-8"
>
> Underqzi
> 6ED
> aqqnzYofJmhldeH
> -------------- next part --------------
> An HTML attachment was scrubbed...
>
> ------------------------------
>
> Message: 5
> Date: Sat, 13 Feb 2010 16:51:58 +0000
> From: Jonathan Cameron <kernel-tko9wxEg+fIOOJlXag/Snyp2UmYkHbXO@public.gmane.org>
> Subject: Re: [spi-devel-general] SPI-ADC
> To: Linus Walleij <linus.ml.walleij-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,    linux kernel
>        <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, arjun rath <rath.arjun-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Message-ID: <4B76D8AE.7040102-tko9wxEg+fIOOJlXag/Snyp2UmYkHbXO@public.gmane.org>
> Content-Type: text/plain; charset=UTF-8
>
> Hi Arjun and Linus,
> >
> >> can anybody share how to start a spi based ADC linux driver.I am having
> a
> >> MAXIM 1242 ADC chip.
> >
> > The ?ernel does not contain any generic ADC subsystem abstraction (I
> > think it would be good if it did), instead most drivers using ADC have
> > their ADC portions stored inside a driver for something else, e.g.
> > drivers/hwmon for ADCs used in temperature monitoring, or
> > drivers/power for ADCs used in monitoring of currents and voltages
> > for power supplies/batteries.
> That's not entirely true.  These are covered by the IIO subsystem which
> is admittedly currently in staging as some elements still need cleaning up.
>
> As a quick summary of IIO.  Except for a few bits of management code, basic
> drivers look pretty much like hwmon.  An example in tree is the tsl2563
> driver
> (under drivers/staging/iio/light) though that one is moving out to ALS when
> Amit has a chance to sort out the relevant patch.
>
> For more advanced drivers (only add support if you have a use as it is a
> fair
> bit more complex) we have support for hardware and software ring buffers,
> an
> events interface which is more or less the equivalent of input without
> cross
> device aggregation.
>
> ADC drivers are under drivers/staging/iio/adc.
>
> I think in mainline we still only have a max1363 driver which covers a lot
> of the i2c maxim parts (more to add after testing).  There are a couple
> more iio using adc drivers in a blackfin tree at:
>
> http://blackfin.uclinux.org/gf/project/linux-kernel/scmsvn/
> (Note these are very much under development!)  Though from a quick look
> all of them are i2c based.  For an spi equivalent, take a look at
> drivers/staging/iio/accel/ where we have the kxsd9 driver (which is another
> simple example of an IIO driver) + lis3l02dq and sca3000 which are on the
> heavy side (probably not a good place to start).
>
> For a general list of devices people are working on, or at least have and
> intend to work on, take a look at:
>
> https://sourceforge.net/apps/mediawiki/iioutils/index.php?title=Device_List
>
> Just for reference, the big up coming change in IIO is a new userspace ABI
> to clean things up before we get too many drivers using the somewhat messy
> old version.
>
> It will still be a little while before we have cleaned up the more
> controversial
> issues in the core (none of which touch on the simpler drivers) but with a
> steady increase in active developers things are speeding up.
>
> So in conclusion, if your use of the driver doesn't fall neatly under hwmon
> or elsewhere, and you don't mind writing for a subsystem which isn't
> entirely
> polished and may change, then IIO might be what you are looking for.
>
> Currently all discussions take place on LKML, but we are working on a more
> focused alternative list which I'll announce once it is sorted out.
>
> Just taking a quick and dirty look at the datasheet for the MAX1242:
>
> * You might have fun getting the required conversion delay before a read.
>  (Chip select must be enabled for 7.5 microsecs before the clock starts)
>
> * Otherwise it is a nice simple chip with no actual control of anything.
>
> Perhaps you can supply some information on your application to guide
> an continuation of this discussion?
>
> Thanks,
>
>
>
> Jonathan Cameron
> >
> > This is a bit bad for driving a generic ADC like this using spidev and,
> > even if it was to be accessed from userspace only, having it under
> > drivers/spi is rather counterintuitive, what happens when the next ADC
> > using I2C turns up? drivers/i2c/chips?
> >
> > I would suggest creating subsystem drivers/adc if you have time and
> > energy, other ideas?
> >
> > Linus Walleij
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel"
> in
> > the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
>
>
>
>
> ------------------------------
>
> Message: 6
> Date: Sat, 13 Feb 2010 12:03:17 -0500
> From: Mike Frysinger <vapier.adi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Subject: Re: [spi-devel-general] SPI-ADC
> To: Jonathan Cameron <kernel-tko9wxEg+fIOOJlXag/Snyp2UmYkHbXO@public.gmane.org>
> Cc: linux kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,        arjun rath
>        <rath.arjun-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> Message-ID:
>        <8bd0f97a1002130903h698c8d4ax4b3b9bfff02157b7-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
> Content-Type: text/plain; charset=UTF-8
>
> On Sat, Feb 13, 2010 at 11:51, Jonathan Cameron wrote:
> > http://blackfin.uclinux.org/gf/project/linux-kernel/scmsvn/
>
> people who like git can always use:
>
> http://blackfin.uclinux.org/git/?p=readonly-mirrors/linux-kernel.git;a=summary
> -mike<http://blackfin.uclinux.org/git/?p=readonly-mirrors/linux-kernel.git;a=summary%0A-mike>
>
>
>
> ------------------------------
>
> Message: 7
> Date: Sat, 13 Feb 2010 19:32:10 +0100 (CET)
> From: "Immo-web" <privileges-BQzCAz/s1vZLBLenUCvkVg@public.gmane.org>
> Subject: [spi-devel-general] [SPAM] Offert : notre guide pour mieux
>        gerer   votre epargne et developper votre patrimoine
> To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> Message-ID: <kxsm5l.me49qn-4StZXCDRhwPgrAmjdVbZJQ@public.gmane.org>
> Content-Type: text/plain; charset="iso-8859-1"
>
>
> -------------- next part --------------
> An HTML attachment was scrubbed...
>
> ------------------------------
>
>
> ------------------------------------------------------------------------------
> SOLARIS 10 is the OS for Data Centers - provides features such as DTrace,
> Predictive Self Healing and Award Winning ZFS. Get Solaris 10 NOW
> http://p.sf.net/sfu/solaris-dev2dev
>
> ------------------------------
>
> _______________________________________________
> spi-devel-general mailing list
> spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/spi-devel-general
>
>
> End of spi-devel-general Digest, Vol 45, Issue 15
> *************************************************
>

--0016e64caef2169a54047f9dcbc6
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi all,<br><br>Thanks to all for the suggestions.<br><br>But whatever drive=
r for ADC i am getting is through I2C connected only.Like any other spi sla=
ve driver,i added for my spi device also and the device is opening also.But=
 now i am trying how to read the data which i am not getting.<br>
<br>=A0 <br><br><div class=3D"gmail_quote">On Sun, Feb 14, 2010 at 12:02 AM=
,  <span dir=3D"ltr">&lt;<a href=3D"mailto:spi-devel-general-request@lists.=
sourceforge.net">spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org</a>&gt;</s=
pan> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, =
204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">Send spi-devel-ge=
neral mailing list submissions to<br>
 =A0 =A0 =A0 =A0<a href=3D"mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org">=
spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org</a><br>
<br>
To subscribe or unsubscribe via the World Wide Web, visit<br>
 =A0 =A0 =A0 =A0<a href=3D"https://lists.sourceforge.net/lists/listinfo/spi=
-devel-general" target=3D"_blank">https://lists.sourceforge.net/lists/listi=
nfo/spi-devel-general</a><br>
or, via email, send a message with subject or body &#39;help&#39; to<br>
 =A0 =A0 =A0 =A0<a href=3D"mailto:spi-devel-general-request-5NWGOfrQmndRYHbF4JBHZw@public.gmane.org=
ge.net">spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org</a><br>
<br>
You can reach the person managing the list at<br>
 =A0 =A0 =A0 =A0<a href=3D"mailto:spi-devel-general-owner-5NWGOfrQmneRv+LV9MX5urNAH6kLmebB@public.gmane.org=
.net">spi-devel-general-owner-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org</a><br>
<br>
When replying, please edit your Subject line so it is more specific<br>
than &quot;Re: Contents of spi-devel-general digest...&quot;<br>
<br>
<br>
Today&#39;s Topics:<br>
<br>
 =A0 1. SPI-ADC (arjun rath)<br>
 =A0 2. Re: SPI-ADC (Ben Gamari)<br>
 =A0 3. Re: SPI-ADC (Linus Walleij)<br>
 =A0 4. [SPAM] ???????????????? ??????????? ?????<br>
 =A0 =A0 =A0( ??????????????? ???????? )<br>
 =A0 5. Re: SPI-ADC (Jonathan Cameron)<br>
 =A0 6. Re: SPI-ADC (Mike Frysinger)<br>
 =A0 7. [SPAM] Offert : notre guide pour mieux gerer =A0 =A0 =A0votre eparg=
ne et<br>
 =A0 =A0 =A0developper votre patrimoine (Immo-web)<br>
<br>
<br>
----------------------------------------------------------------------<br>
<br>
Message: 1<br>
Date: Sat, 13 Feb 2010 11:18:40 +0530<br>
From: arjun rath &lt;<a href=3D"mailto:rath.arjun-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">rath.arjun@gma=
il.com</a>&gt;<br>
Subject: [spi-devel-general] SPI-ADC<br>
To: <a href=3D"mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org">spi-devel-ge=
neral-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org</a><br>
Message-ID:<br>
 =A0 =A0 =A0 =A0&lt;<a href=3D"mailto:dc6d3181002122148v6451ebffka164de2887=
38485d-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org">dc6d3181002122148v6451ebffka164de288738485d-JsoAwUIsXos@public.gmane.org=
il.com</a>&gt;<br>
Content-Type: text/plain; charset=3D&quot;iso-8859-1&quot;<br>
<br>
Hi everybody,<br>
<br>
can anybody share how to start a spi based ADC linux driver.I am having a<b=
r>
MAXIM 1242 ADC chip.<br>
<br>
Can anybody share some reference driver for the same chip<br>
<br>
Thanks in advance<br>
<br>
Arjun<br>
-------------- next part --------------<br>
An HTML attachment was scrubbed...<br>
<br>
------------------------------<br>
<br>
Message: 2<br>
Date: Sat, 13 Feb 2010 01:38:16 -0500<br>
From: Ben Gamari &lt;<a href=3D"mailto:bgamari-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">bgamari-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org=
</a>&gt;<br>
Subject: Re: [spi-devel-general] SPI-ADC<br>
To: spi-devel-general &lt;<a href=3D"mailto:spi-devel-general-5NWGOfrQmnegEbju0hdhLg@public.gmane.org=
orge.net">spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org</a>&gt;<br>
Message-ID: &lt;1266042736-sup-3579@ben-laptop&gt;<br>
Content-Type: text/plain; charset=3DUTF-8<br>
<br>
Excerpts from arjun rath&#39;s message of Sat Feb 13 00:48:40 -0500 2010:<b=
r>
&gt; Hi everybody,<br>
&gt;<br>
&gt; can anybody share how to start a spi based ADC linux driver.I am havin=
g a<br>
&gt; MAXIM 1242 ADC chip.<br>
&gt;<br>
&gt; Can anybody share some reference driver for the same chip<br>
&gt;<br>
I&#39;ve recently been working on a design for a data acquisition<br>
board to interface with the Beagle Board using the Maxim 5134 and 1270.<br>
I&#39;m using the spidev driver to interface with the devices from<br>
user-space. Documentation on this driver can be found in the<br>
Documentation/spi/spidev file of the Linux kernel tree. My code can be<br>
found at [1]. Hope things are going well,<br>
<br>
- Ben<br>
<br>
<br>
[1] <a href=3D"http://goldnerlab.physics.umass.edu/git?p=3Dtracker.git;a=3D=
tree" target=3D"_blank">http://goldnerlab.physics.umass.edu/git?p=3Dtracker=
.git;a=3Dtree</a><br>
<br>
<br>
<br>
------------------------------<br>
<br>
Message: 3<br>
Date: Sat, 13 Feb 2010 14:48:22 +0100<br>
From: Linus Walleij &lt;<a href=3D"mailto:linus.ml.walleij-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">linus=
.ml.walleij-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;<br>
Subject: Re: [spi-devel-general] SPI-ADC<br>
To: arjun rath &lt;<a href=3D"mailto:rath.arjun-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">rath.arjun@gmail=
.com</a>&gt;<br>
Cc: <a href=3D"mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org">spi-devel-ge=
neral-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org</a>, =A0 =A0linux kernel<br>
 =A0 =A0 =A0 =A0&lt;<a href=3D"mailto:linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org">linux-k=
ernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org</a>&gt;<br>
Message-ID:<br>
 =A0 =A0 =A0 =A0&lt;<a href=3D"mailto:63386a3d1002130548y7c839072y85097a9bc=
df66cad-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org">63386a3d1002130548y7c839072y85097a9bcdf66cad@mail.g=
mail.com</a>&gt;<br>
Content-Type: text/plain; charset=3DUTF-8<br>
<br>
2010/2/13 arjun rath &lt;<a href=3D"mailto:rath.arjun-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">rath.arjun=
@gmail.com</a>&gt;:<br>
<br>
&gt; can anybody share how to start a spi based ADC linux driver.I am havin=
g a<br>
&gt; MAXIM 1242 ADC chip.<br>
<br>
The ?ernel does not contain any generic ADC subsystem abstraction (I<br>
think it would be good if it did), instead most drivers using ADC have<br>
their ADC portions stored inside a driver for something else, e.g.<br>
drivers/hwmon for ADCs used in temperature monitoring, or<br>
drivers/power for ADCs used in monitoring of currents and voltages<br>
for power supplies/batteries.<br>
<br>
This is a bit bad for driving a generic ADC like this using spidev and,<br>
even if it was to be accessed from userspace only, having it under<br>
drivers/spi is rather counterintuitive, what happens when the next ADC<br>
using I2C turns up? drivers/i2c/chips?<br>
<br>
I would suggest creating subsystem drivers/adc if you have time and<br>
energy, other ideas?<br>
<br>
Linus Walleij<br>
<br>
<br>
<br>
------------------------------<br>
<br>
Message: 4<br>
Date: Sat, 13 Feb 2010 18:18:04 +0300<br>
From: &quot; ??????????????? ???????? &quot; =A0 =A0 =A0&lt;<a href=3D"mail=
to:debywepocehugaly-oe7qfRrRQfd4OK5fxMSSsQ@public.gmane.org">debywepocehugaly-oe7qfRrRQfd4OK5fxMSSsQ@public.gmane.org</a>&gt;<br>
Subject: [spi-devel-general] [SPAM] ???????????????? ??????????? ?????<br>
To: <a href=3D"mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org">spi-devel-ge=
neral-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org</a><br>
Message-ID: &lt;<a href=3D"mailto:1162144242.20100213181804-oe7qfRrRQfd4OK5fxMSSsQ@public.gmane.org">116=
2144242.20100213181804-oe7qfRrRQfd4OK5fxMSSsQ@public.gmane.org</a>&gt;<br>
Content-Type: text/plain; charset=3D&quot;utf-8&quot;<br>
<br>
Underqzi<br>
6ED<br>
aqqnzYofJmhldeH<br>
-------------- next part --------------<br>
An HTML attachment was scrubbed...<br>
<br>
------------------------------<br>
<br>
Message: 5<br>
Date: Sat, 13 Feb 2010 16:51:58 +0000<br>
From: Jonathan Cameron &lt;<a href=3D"mailto:kernel-tko9wxEg+fIOOJlXag/Snyp2UmYkHbXO@public.gmane.org">=
kernel-tko9wxEg+fIOOJlXag/Snyp2UmYkHbXO@public.gmane.org</a>&gt;<br>
Subject: Re: [spi-devel-general] SPI-ADC<br>
To: Linus Walleij &lt;<a href=3D"mailto:linus.ml.walleij-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">linus.m=
l.walleij-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;<br>
Cc: <a href=3D"mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org">spi-devel-ge=
neral-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org</a>, =A0 =A0linux kernel<br>
 =A0 =A0 =A0 =A0&lt;<a href=3D"mailto:linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org">linux-k=
ernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org</a>&gt;, arjun rath &lt;<a href=3D"mailto:rath.arjun@=
gmail.com">rath.arjun-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;<br>
Message-ID: &lt;<a href=3D"mailto:4B76D8AE.7040102-tko9wxEg+fIOOJlXag/Snyp2UmYkHbXO@public.gmane.org">4=
B76D8AE.7040102-tko9wxEg+fIOOJlXag/Snyp2UmYkHbXO@public.gmane.org</a>&gt;<br>
Content-Type: text/plain; charset=3DUTF-8<br>
<br>
Hi Arjun and Linus,<br>
&gt;<br>
&gt;&gt; can anybody share how to start a spi based ADC linux driver.I am h=
aving a<br>
&gt;&gt; MAXIM 1242 ADC chip.<br>
&gt;<br>
&gt; The ?ernel does not contain any generic ADC subsystem abstraction (I<b=
r>
&gt; think it would be good if it did), instead most drivers using ADC have=
<br>
&gt; their ADC portions stored inside a driver for something else, e.g.<br>
&gt; drivers/hwmon for ADCs used in temperature monitoring, or<br>
&gt; drivers/power for ADCs used in monitoring of currents and voltages<br>
&gt; for power supplies/batteries.<br>
That&#39;s not entirely true. =A0These are covered by the IIO subsystem whi=
ch<br>
is admittedly currently in staging as some elements still need cleaning up.=
<br>
<br>
As a quick summary of IIO. =A0Except for a few bits of management code, bas=
ic<br>
drivers look pretty much like hwmon. =A0An example in tree is the tsl2563 d=
river<br>
(under drivers/staging/iio/light) though that one is moving out to ALS when=
<br>
Amit has a chance to sort out the relevant patch.<br>
<br>
For more advanced drivers (only add support if you have a use as it is a fa=
ir<br>
bit more complex) we have support for hardware and software ring buffers, a=
n<br>
events interface which is more or less the equivalent of input without cros=
s<br>
device aggregation.<br>
<br>
ADC drivers are under drivers/staging/iio/adc.<br>
<br>
I think in mainline we still only have a max1363 driver which covers a lot<=
br>
of the i2c maxim parts (more to add after testing). =A0There are a couple<b=
r>
more iio using adc drivers in a blackfin tree at:<br>
<br>
<a href=3D"http://blackfin.uclinux.org/gf/project/linux-kernel/scmsvn/" tar=
get=3D"_blank">http://blackfin.uclinux.org/gf/project/linux-kernel/scmsvn/<=
/a><br>
(Note these are very much under development!) =A0Though from a quick look<b=
r>
all of them are i2c based. =A0For an spi equivalent, take a look at<br>
drivers/staging/iio/accel/ where we have the kxsd9 driver (which is another=
<br>
simple example of an IIO driver) + lis3l02dq and sca3000 which are on the<b=
r>
heavy side (probably not a good place to start).<br>
<br>
For a general list of devices people are working on, or at least have and<b=
r>
intend to work on, take a look at:<br>
<br>
<a href=3D"https://sourceforge.net/apps/mediawiki/iioutils/index.php?title=
=3DDevice_List" target=3D"_blank">https://sourceforge.net/apps/mediawiki/ii=
outils/index.php?title=3DDevice_List</a><br>
<br>
Just for reference, the big up coming change in IIO is a new userspace ABI<=
br>
to clean things up before we get too many drivers using the somewhat messy<=
br>
old version.<br>
<br>
It will still be a little while before we have cleaned up the more controve=
rsial<br>
issues in the core (none of which touch on the simpler drivers) but with a<=
br>
steady increase in active developers things are speeding up.<br>
<br>
So in conclusion, if your use of the driver doesn&#39;t fall neatly under h=
wmon<br>
or elsewhere, and you don&#39;t mind writing for a subsystem which isn&#39;=
t entirely<br>
polished and may change, then IIO might be what you are looking for.<br>
<br>
Currently all discussions take place on LKML, but we are working on a more<=
br>
focused alternative list which I&#39;ll announce once it is sorted out.<br>
<br>
Just taking a quick and dirty look at the datasheet for the MAX1242:<br>
<br>
* You might have fun getting the required conversion delay before a read.<b=
r>
=A0(Chip select must be enabled for 7.5 microsecs before the clock starts)<=
br>
<br>
* Otherwise it is a nice simple chip with no actual control of anything.<br=
>
<br>
Perhaps you can supply some information on your application to guide<br>
an continuation of this discussion?<br>
<br>
Thanks,<br>
<br>
<br>
<br>
Jonathan Cameron<br>
&gt;<br>
&gt; This is a bit bad for driving a generic ADC like this using spidev and=
,<br>
&gt; even if it was to be accessed from userspace only, having it under<br>
&gt; drivers/spi is rather counterintuitive, what happens when the next ADC=
<br>
&gt; using I2C turns up? drivers/i2c/chips?<br>
&gt;<br>
&gt; I would suggest creating subsystem drivers/adc if you have time and<br=
>
&gt; energy, other ideas?<br>
&gt;<br>
&gt; Linus Walleij<br>
&gt; --<br>
&gt; To unsubscribe from this list: send the line &quot;unsubscribe linux-k=
ernel&quot; in<br>
&gt; the body of a message to <a href=3D"mailto:majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org">=
majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org</a><br>
&gt; More majordomo info at =A0<a href=3D"http://vger.kernel.org/majordomo-=
info.html" target=3D"_blank">http://vger.kernel.org/majordomo-info.html</a>=
<br>
&gt; Please read the FAQ at =A0<a href=3D"http://www.tux.org/lkml/" target=
=3D"_blank">http://www.tux.org/lkml/</a><br>
<br>
<br>
<br>
<br>
------------------------------<br>
<br>
Message: 6<br>
Date: Sat, 13 Feb 2010 12:03:17 -0500<br>
From: Mike Frysinger &lt;<a href=3D"mailto:vapier.adi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">vapier.adi=
@gmail.com</a>&gt;<br>
Subject: Re: [spi-devel-general] SPI-ADC<br>
To: Jonathan Cameron &lt;<a href=3D"mailto:kernel-tko9wxEg+fIOOJlXag/Snyp2UmYkHbXO@public.gmane.org">ke=
rnel-tko9wxEg+fIOOJlXag/Snyp2UmYkHbXO@public.gmane.org</a>&gt;<br>
Cc: linux kernel &lt;<a href=3D"mailto:linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org">linux-=
kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org</a>&gt;, =A0 =A0 =A0 =A0arjun rath<br>
 =A0 =A0 =A0 =A0&lt;<a href=3D"mailto:rath.arjun-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">rath.arjun@gmai=
l.com</a>&gt;, <a href=3D"mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org">s=
pi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org</a><br>
Message-ID:<br>
 =A0 =A0 =A0 =A0&lt;<a href=3D"mailto:8bd0f97a1002130903h698c8d4ax4b3b9bfff=
02157b7-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org">8bd0f97a1002130903h698c8d4ax4b3b9bfff02157b7@mail.g=
mail.com</a>&gt;<br>
Content-Type: text/plain; charset=3DUTF-8<br>
<br>
On Sat, Feb 13, 2010 at 11:51, Jonathan Cameron wrote:<br>
&gt; <a href=3D"http://blackfin.uclinux.org/gf/project/linux-kernel/scmsvn/=
" target=3D"_blank">http://blackfin.uclinux.org/gf/project/linux-kernel/scm=
svn/</a><br>
<br>
people who like git can always use:<br>
<a href=3D"http://blackfin.uclinux.org/git/?p=3Dreadonly-mirrors/linux-kern=
el.git;a=3Dsummary%0A-mike" target=3D"_blank">http://blackfin.uclinux.org/g=
it/?p=3Dreadonly-mirrors/linux-kernel.git;a=3Dsummary<br>
-mike</a><br>
<br>
<br>
<br>
------------------------------<br>
<br>
Message: 7<br>
Date: Sat, 13 Feb 2010 19:32:10 +0100 (CET)<br>
From: &quot;Immo-web&quot; &lt;<a href=3D"mailto:privileges-BQzCAz/s1vZLBLenUCvkVg@public.gmane.org">=
privileges-BQzCAz/s1vZLBLenUCvkVg@public.gmane.org</a>&gt;<br>
Subject: [spi-devel-general] [SPAM] Offert : notre guide pour mieux<br>
 =A0 =A0 =A0 =A0gerer =A0 votre epargne et developper votre patrimoine<br>
To: <a href=3D"mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org">spi-devel-ge=
neral-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org</a><br>
Message-ID: &lt;<a href=3D"mailto:kxsm5l.me49qn-4StZXCDRhwPgrAmjdVbZJQ@public.gmane.org">kxsm5l.me=
49qn-4StZXCDRhwPgrAmjdVbZJQ@public.gmane.org</a>&gt;<br>
Content-Type: text/plain; charset=3D&quot;iso-8859-1&quot;<br>
<br>
<br>
-------------- next part --------------<br>
An HTML attachment was scrubbed...<br>
<br>
------------------------------<br>
<br>
---------------------------------------------------------------------------=
---<br>
SOLARIS 10 is the OS for Data Centers - provides features such as DTrace,<b=
r>
Predictive Self Healing and Award Winning ZFS. Get Solaris 10 NOW<br>
<a href=3D"http://p.sf.net/sfu/solaris-dev2dev" target=3D"_blank">http://p.=
sf.net/sfu/solaris-dev2dev</a><br>
<br>
------------------------------<br>
<br>
_______________________________________________<br>
spi-devel-general mailing list<br>
<a href=3D"mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org">spi-devel-genera=
l@lists.sourceforge.net</a><br>
<a href=3D"https://lists.sourceforge.net/lists/listinfo/spi-devel-general" =
target=3D"_blank">https://lists.sourceforge.net/lists/listinfo/spi-devel-ge=
neral</a><br>
<br>
<br>
End of spi-devel-general Digest, Vol 45, Issue 15<br>
*************************************************<br>
</blockquote></div><br>

--0016e64caef2169a54047f9dcbc6--


--===============3340511686250381002==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
SOLARIS 10 is the OS for Data Centers - provides features such as DTrace,
Predictive Self Healing and Award Winning ZFS. Get Solaris 10 NOW
http://p.sf.net/sfu/solaris-dev2dev
--===============3340511686250381002==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
spi-devel-general mailing list
spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
https://lists.sourceforge.net/lists/listinfo/spi-devel-general

--===============3340511686250381002==--
