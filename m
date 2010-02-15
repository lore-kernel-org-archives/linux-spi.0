From: arjun rath <rath.arjun-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: SPI-ADC
Date: Mon, 15 Feb 2010 09:59:18 +0530
Message-ID: <dc6d3181002142029j13a9e57la45aa90a269404fa@mail.gmail.com>
References: <dc6d3181002122148v6451ebffka164de288738485d@mail.gmail.com>
	<63386a3d1002130548y7c839072y85097a9bcdf66cad@mail.gmail.com>
	<4B76D8AE.7040102@jic23.retrosnub.co.uk>
	<63386a3d1002131320u5afbc35ak2bc3533aab3f1e54@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8267980697452961062=="
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Jonathan Cameron <kernel-tko9wxEg+fIOOJlXag/Snyp2UmYkHbXO@public.gmane.org>,
	linux kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Linus Walleij <linus.ml.walleij-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <63386a3d1002131320u5afbc35ak2bc3533aab3f1e54-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

--===============8267980697452961062==
Content-Type: multipart/alternative; boundary=0016e64b92de81c76c047f9c0fd6

--0016e64b92de81c76c047f9c0fd6
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi all,

Thanks for the suggestions.

Actually i am new to SPI,and all related ADC drivers in the latest kernels
are through I2C.i am going to use an temperature module through this adc
connected through SPI.so i think i am going to read the data only,no data
writing is required.

Let us try and see .If any body is having a reference driver for SPI based
ADC,they can share.

Regards

Arjun

On Sun, Feb 14, 2010 at 2:50 AM, Linus Walleij
<linus.ml.walleij-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>wrote:

> 2010/2/13 Jonathan Cameron <kernel-tko9wxEg+fIOOJlXag/Snyp2UmYkHbXO@public.gmane.org>:
>
> >>> can anybody share how to start a spi based ADC linux driver.I am havi=
ng
> a
> >>> MAXIM 1242 ADC chip.
> >>
> >> The =E1=B8=B1ernel does not contain any generic ADC subsystem abstract=
ion
> >> (...)
> >
> > That's not entirely true.  These are covered by the IIO subsystem which
> > is admittedly currently in staging as some elements still need cleaning
> up.
> > (...)
> > ADC drivers are under drivers/staging/iio/adc.
>
> Great stuff. I knew about IIO and then it fell out of my mind, how
> could I...
>
> What strikes me especially about IIO is the underlying assumption, which =
I
> think ought to be written in clear somewhere where I missed it, and that
> is that all IIO drivers are supposed to deliver values and be controller
> from
> userspace with this nice ABI, and nothing's wrong with that of course.
>
> But I'm hinting about a few in-kernel uses: for AB3100 we have a battery
> charging mechanism, which use a (calibrated) ADC value supporting the
> bulk of the driver in the power/ subsystem.
>
> As it looks today IIO is not intended for the case where another subsyste=
m
> needs to grab and use and ADC for its own purposes. Is this correct or di=
d
> I get it all wrong?
>
> Would you say it'd be a good idea to hack the IIO ADC interface (for
> example) to be used also internally in the kernel, or would that violate
> the idea behind IIO?
>
> If these are disparate categories it would warrant a separate adc/
> subsystem, see.
>
> > Currently all discussions take place on LKML, but we are working on a
> more
> > focused alternative list which I'll announce once it is sorted out.
>
> LKML is just fine with me, for one.
>
> Yours,
> Linus Walleij
>

--0016e64b92de81c76c047f9c0fd6
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi all,<br><br>Thanks for the suggestions.<br><br>Actually i am new to SPI,=
and all related ADC drivers in the latest kernels are through I2C.i am goin=
g to use an temperature module through this adc connected through SPI.so i =
think i am going to read the data only,no data writing is required.<br>
<br>Let us try and see .If any body is having a reference driver for SPI ba=
sed ADC,they can share.<br><br>Regards<br><br>Arjun <br><br><div class=3D"g=
mail_quote">On Sun, Feb 14, 2010 at 2:50 AM, Linus Walleij <span dir=3D"ltr=
">&lt;<a href=3D"mailto:linus.ml.walleij-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">linus.ml.walleij@gmail.=
com</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, =
204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">2010/2/13 Jonatha=
n Cameron &lt;<a href=3D"mailto:kernel-tko9wxEg+fIOOJlXag/Snyp2UmYkHbXO@public.gmane.org">kernel@jic23.=
retrosnub.co.uk</a>&gt;:<br>

<div class=3D"im"><br>
&gt;&gt;&gt; can anybody share how to start a spi based ADC linux driver.I =
am having a<br>
&gt;&gt;&gt; MAXIM 1242 ADC chip.<br>
&gt;&gt;<br>
&gt;&gt; The =E1=B8=B1ernel does not contain any generic ADC subsystem abst=
raction<br>
</div>&gt;&gt; (...)<br>
<div class=3D"im">&gt;<br>
&gt; That&#39;s not entirely true. =C2=A0These are covered by the IIO subsy=
stem which<br>
&gt; is admittedly currently in staging as some elements still need cleanin=
g up.<br>
</div>&gt; (...)<br>
<div class=3D"im">&gt; ADC drivers are under drivers/staging/iio/adc.<br>
<br>
</div>Great stuff. I knew about IIO and then it fell out of my mind, how<br=
>
could I...<br>
<br>
What strikes me especially about IIO is the underlying assumption, which I<=
br>
think ought to be written in clear somewhere where I missed it, and that<br=
>
is that all IIO drivers are supposed to deliver values and be controller fr=
om<br>
userspace with this nice ABI, and nothing&#39;s wrong with that of course.<=
br>
<br>
But I&#39;m hinting about a few in-kernel uses: for AB3100 we have a batter=
y<br>
charging mechanism, which use a (calibrated) ADC value supporting the<br>
bulk of the driver in the power/ subsystem.<br>
<br>
As it looks today IIO is not intended for the case where another subsystem<=
br>
needs to grab and use and ADC for its own purposes. Is this correct or did<=
br>
I get it all wrong?<br>
<br>
Would you say it&#39;d be a good idea to hack the IIO ADC interface (for<br=
>
example) to be used also internally in the kernel, or would that violate<br=
>
the idea behind IIO?<br>
<br>
If these are disparate categories it would warrant a separate adc/<br>
subsystem, see.<br>
<div class=3D"im"><br>
&gt; Currently all discussions take place on LKML, but we are working on a =
more<br>
&gt; focused alternative list which I&#39;ll announce once it is sorted out=
.<br>
<br>
</div>LKML is just fine with me, for one.<br>
<br>
Yours,<br>
<font color=3D"#888888">Linus Walleij<br>
</font></blockquote></div><br>

--0016e64b92de81c76c047f9c0fd6--


--===============8267980697452961062==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
SOLARIS 10 is the OS for Data Centers - provides features such as DTrace,
Predictive Self Healing and Award Winning ZFS. Get Solaris 10 NOW
http://p.sf.net/sfu/solaris-dev2dev
--===============8267980697452961062==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
spi-devel-general mailing list
spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
https://lists.sourceforge.net/lists/listinfo/spi-devel-general

--===============8267980697452961062==--
