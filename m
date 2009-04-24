From: Arnav Das <arnavdas29-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: General SPI question
Date: Fri, 24 Apr 2009 11:58:08 +0530
Message-ID: <8ee9e87c0904232328j7f912eb6v3d0b9cb0321793a9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4739953114614200141=="
Cc: linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, Stefan Roese <sr-ynQEQJNshbs@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

--===============4739953114614200141==
Content-Type: multipart/alternative; boundary=0016e6dee96e95528a04684719ec

--0016e6dee96e95528a04684719ec
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi,

Thanks a lot and sorry for the mistakes. I have gone through the trm of the
adc as well as the omap driver. my question is that i want to interact the
adc to the board. now should i directly use the omap driver or should i mak
one of my own. if i make one of my own then i would like to know how would
the spi registers be changed by driver. should it include the omap2 driver
or is the fuctionality provided directly when i include spi.h.

another doubt: when and why is the spidev.c/h used?

i am deeply grateful towards you for helping me out
thanks
Arnav

On Fri, Apr 24, 2009 at 11:50 AM, David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>wrote:

> On Thursday 23 April 2009, Arnav Das wrote:
> > i am a newbie
>
> Lesson #1:  make sure your Subject: lines match the message
> topic (I did a partial repair) and don't post to the wrong
> list (e.g. PPC lists for OMAP questions).
>
>
> > and am doing a project on beagle board(running
> > omap3530). i am interfacing an adc(ads7886) to the beagleboard via
> > spi. need to know how the spi works
>
> Read the ads7886 data sheet, in this case.  It uses
> a subset of SPI ... no input commands, just a 12-bit
> sample returned each time chipselect pulses.
>
>
> > and how a module can access the
> > spi registers of the omap. if someones already made an adc driver can
> > they mail me?
>
> Use drivers/spi/omap2_mcspi.c on OMAP3 boards, at
> least to start with.  If you want streaming conversions
> you may want to use different modes than are currently
> supported by that driver.
>
> - Dave
>
>
>
>
>

--0016e6dee96e95528a04684719ec
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div>Hi,</div>
<div>=A0</div>
<div>Thanks a lot and sorry for the mistakes. I have gone through the trm o=
f the adc as well as the omap driver. my question is that i want to interac=
t the adc to the board. now should i directly use the omap driver or should=
 i mak one of my own. if i make one of my own then i would like to know how=
 would the spi registers be changed by driver. should it include the omap2 =
driver or is the fuctionality provided directly when i include spi.h.</div>

<div>=A0</div>
<div>another doubt: when and why is the spidev.c/h used?</div>
<div>=A0</div>
<div>i am deeply grateful towards you for helping me out</div>
<div>thanks</div>
<div>Arnav<br><br></div>
<div class=3D"gmail_quote">On Fri, Apr 24, 2009 at 11:50 AM, David Brownell=
 <span dir=3D"ltr">&lt;<a href=3D"mailto:david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org">david-b@pacbe=
ll.net</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"PADDING-LEFT: 1ex; MARGIN: 0px 0=
px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">On Thursday 23 April 2009, Arnav=
 Das wrote:<br>&gt; i am a newbie<br><br>Lesson #1: =A0make sure your Subje=
ct: lines match the message<br>
topic (I did a partial repair) and don&#39;t post to the wrong<br>list (e.g=
. PPC lists for OMAP questions).<br><br><br>&gt; and am doing a project on =
beagle board(running<br>&gt; omap3530). i am interfacing an adc(ads7886) to=
 the beagleboard via<br>
&gt; spi. need to know how the spi works<br><br>Read the ads7886 data sheet=
, in this case. =A0It uses<br>a subset of SPI ... no input commands, just a=
 12-bit<br>sample returned each time chipselect pulses.<br><br><br>&gt; and=
 how a module can access the<br>
&gt; spi registers of the omap. if someones already made an adc driver can<=
br>&gt; they mail me?<br><br>Use drivers/spi/omap2_mcspi.c on OMAP3 boards,=
 at<br>least to start with. =A0If you want streaming conversions<br>you may=
 want to use different modes than are currently<br>
supported by that driver.<br><br>- Dave<br><br><br><br><br></blockquote></d=
iv><br>

--0016e6dee96e95528a04684719ec--


--===============4739953114614200141==
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
--===============4739953114614200141==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
spi-devel-general mailing list
spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
https://lists.sourceforge.net/lists/listinfo/spi-devel-general

--===============4739953114614200141==--
