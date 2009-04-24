From: Arnav Das <arnavdas29-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: General SPI question
Date: Fri, 24 Apr 2009 13:58:49 +0530
Message-ID: <8ee9e87c0904240128y1615625aiae9468de0a02643@mail.gmail.com>
References: <8ee9e87c0904232328j7f912eb6v3d0b9cb0321793a9@mail.gmail.com>
	<200904240031.53343.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=0016364d20a7369417046848c97c
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200904240031.53343.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

--0016364d20a7369417046848c97c
Content-Type: multipart/alternative; boundary=0016364d20a7369406046848c97a

--0016364d20a7369406046848c97a
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

thanks for the quick reply.

i basically want to make a cro out of the adc and the beaglebard. so
whatever input i get, i need to show it in a graphical manner on a real time
basis. this probably can be forthur utilised in as a ecg in medical
applications and further improvements can be made.

could you please guide me to a knowledgebase from where i can learn all
about spi, drivers and spi drivers(platform independant, if possible) as my
main focus of the project is the graphical part wherein i will use the data
collected to output on the screen with proper gui.

i got this adc driver from blackfin/uclinux resources please see whether it
is ok?

Thanks a lot,
Arnav

On Fri, Apr 24, 2009 at 1:01 PM, David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org> wrote:

> [ I dropped the PPC folk from the cc list.. ]
>
> On Thursday 23 April 2009, Arnav Das wrote:
> > Hi,
> >
> > Thanks a lot and sorry for the mistakes. I have gone through the trm of
> the
> > adc as well as the omap driver. my question is that i want to interact
> the
> > adc to the board. now should i directly use the omap driver or should i
> mak
> > one of my own.
>
> Unless you have a compelling reason, use the OMAP controller driver.
>
> You'd write a spi_driver -- a *REALLY* simple one -- using interfaces
> described in Documentation/spi/spi-summary for the lower level.  Almost
> all the work involved would be in the upper level interface:  presenting
> the data to whatever needs it.  Maybe sysfs, maybe not; you've not said
> anything about how you need to use this data.  That would usually be
> the first thing to figure out...
>
>
> > if i make one of my own then i would like to know how would
> > the spi registers be changed by driver. should it include the omap2
> driver
> > or is the fuctionality provided directly when i include spi.h.
>
> You should end up with a simple ADC driver that can hook up to
> any platform's SPI controller.  Your driver will talk to a
> "struct spi_device" and will be usable on non-OMAP boards.
>
>
> > another doubt: when and why is the spidev.c/h used?
>
> When you want a "userspace driver" instead of a kernel driver.
>
> - Dave
>
>
> > i am deeply grateful towards you for helping me out
> > thanks
> > Arnav
> >
> > On Fri, Apr 24, 2009 at 11:50 AM, David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org
> >wrote:
> >
> > > On Thursday 23 April 2009, Arnav Das wrote:
> > > > i am a newbie
> > >
> > > Lesson #1:  make sure your Subject: lines match the message
> > > topic (I did a partial repair) and don't post to the wrong
> > > list (e.g. PPC lists for OMAP questions).
> > >
> > >
> > > > and am doing a project on beagle board(running
> > > > omap3530). i am interfacing an adc(ads7886) to the beagleboard via
> > > > spi. need to know how the spi works
> > >
> > > Read the ads7886 data sheet, in this case.  It uses
> > > a subset of SPI ... no input commands, just a 12-bit
> > > sample returned each time chipselect pulses.
> > >
> > >
> > > > and how a module can access the
> > > > spi registers of the omap. if someones already made an adc driver can
> > > > they mail me?
> > >
> > > Use drivers/spi/omap2_mcspi.c on OMAP3 boards, at
> > > least to start with.  If you want streaming conversions
> > > you may want to use different modes than are currently
> > > supported by that driver.
> > >
> > > - Dave
> > >
> > >
> > >
> > >
> > >
> >
>
>
>

--0016364d20a7369406046848c97a
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div>thanks for the quick reply.</div>
<div>=A0</div>
<div>i basically want to make a cro out of the adc and the beaglebard. so w=
hatever input i get, i need to show it in a graphical manner on a real time=
 basis. this probably can be forthur utilised in as a ecg in medical applic=
ations and further improvements can be made. </div>

<div>=A0</div>
<div>could you please guide me to a knowledgebase from where i can learn al=
l about spi, drivers and spi drivers(platform independant, if possible) as =
my main focus of the project is the graphical part wherein i will use the d=
ata collected to output on the screen with proper gui.</div>

<div>=A0</div>
<div>i got this adc driver from blackfin/uclinux resources please see wheth=
er it is ok?</div>
<div>=A0</div>
<div>Thanks a lot,</div>
<div>Arnav<br><br></div>
<div class=3D"gmail_quote">On Fri, Apr 24, 2009 at 1:01 PM, David Brownell =
<span dir=3D"ltr">&lt;<a href=3D"mailto:david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org">david-b@pacbel=
l.net</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"PADDING-LEFT: 1ex; MARGIN: 0px 0=
px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">[ I dropped the PPC folk from th=
e cc list.. ]<br>
<div class=3D"im"><br>On Thursday 23 April 2009, Arnav Das wrote:<br></div>
<div class=3D"im">&gt; Hi,<br>&gt;<br>&gt; Thanks a lot and sorry for the m=
istakes. I have gone through the trm of the<br>&gt; adc as well as the omap=
 driver. my question is that i want to interact the<br>&gt; adc to the boar=
d. now should i directly use the omap driver or should i mak<br>
&gt; one of my own.<br><br></div>Unless you have a compelling reason, use t=
he OMAP controller driver.<br><br>You&#39;d write a spi_driver -- a *REALLY=
* simple one -- using interfaces<br>described in Documentation/spi/spi-summ=
ary for the lower level. =A0Almost<br>
all the work involved would be in the upper level interface: =A0presenting<=
br>the data to whatever needs it. =A0Maybe sysfs, maybe not; you&#39;ve not=
 said<br>anything about how you need to use this data. =A0That would usuall=
y be<br>
the first thing to figure out...<br>
<div class=3D"im"><br><br>&gt; if i make one of my own then i would like to=
 know how would<br>&gt; the spi registers be changed by driver. should it i=
nclude the omap2 driver<br>&gt; or is the fuctionality provided directly wh=
en i include spi.h.<br>
<br></div>You should end up with a simple ADC driver that can hook up to<br=
>any platform&#39;s SPI controller. =A0Your driver will talk to a<br>&quot;=
struct spi_device&quot; and will be usable on non-OMAP boards.<br>
<div class=3D"im"><br><br>&gt; another doubt: when and why is the spidev.c/=
h used?<br><br></div>When you want a &quot;userspace driver&quot; instead o=
f a kernel driver.<br><br>- Dave<br>
<div>
<div></div>
<div class=3D"h5"><br><br>&gt; i am deeply grateful towards you for helping=
 me out<br>&gt; thanks<br>&gt; Arnav<br>&gt;<br>&gt; On Fri, Apr 24, 2009 a=
t 11:50 AM, David Brownell &lt;<a href=3D"mailto:david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org">david=
-b@pacbell.net</a>&gt;wrote:<br>
&gt;<br>&gt; &gt; On Thursday 23 April 2009, Arnav Das wrote:<br>&gt; &gt; =
&gt; i am a newbie<br>&gt; &gt;<br>&gt; &gt; Lesson #1: =A0make sure your S=
ubject: lines match the message<br>&gt; &gt; topic (I did a partial repair)=
 and don&#39;t post to the wrong<br>
&gt; &gt; list (e.g. PPC lists for OMAP questions).<br>&gt; &gt;<br>&gt; &g=
t;<br>&gt; &gt; &gt; and am doing a project on beagle board(running<br>&gt;=
 &gt; &gt; omap3530). i am interfacing an adc(ads7886) to the beagleboard v=
ia<br>
&gt; &gt; &gt; spi. need to know how the spi works<br>&gt; &gt;<br>&gt; &gt=
; Read the ads7886 data sheet, in this case. =A0It uses<br>&gt; &gt; a subs=
et of SPI ... no input commands, just a 12-bit<br>&gt; &gt; sample returned=
 each time chipselect pulses.<br>
&gt; &gt;<br>&gt; &gt;<br>&gt; &gt; &gt; and how a module can access the<br=
>&gt; &gt; &gt; spi registers of the omap. if someones already made an adc =
driver can<br>&gt; &gt; &gt; they mail me?<br>&gt; &gt;<br>&gt; &gt; Use dr=
ivers/spi/omap2_mcspi.c on OMAP3 boards, at<br>
&gt; &gt; least to start with. =A0If you want streaming conversions<br>&gt;=
 &gt; you may want to use different modes than are currently<br>&gt; &gt; s=
upported by that driver.<br>&gt; &gt;<br>&gt; &gt; - Dave<br>&gt; &gt;<br>
&gt; &gt;<br>&gt; &gt;<br>&gt; &gt;<br>&gt; &gt;<br>&gt;<br><br><br></div><=
/div></blockquote></div><br>

--0016364d20a7369406046848c97a--

--0016364d20a7369417046848c97c
Content-Type: application/octet-stream; name="bfin_spi_adc.c"
Content-Disposition: attachment; filename="bfin_spi_adc.c"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_ftwmeuqd0

I2luY2x1ZGUgPGxpbnV4L2tlcm5lbC5oPg0KI2luY2x1ZGUgPGxpbnV4L21vZHVsZS5oPg0KI2lu
Y2x1ZGUgPGxpbnV4L3NjaGVkLmg+DQojaW5jbHVkZSA8bGludXgvd2FpdC5oPg0KI2luY2x1ZGUg
PGxpbnV4L3BvbGwuaD4NCiNpbmNsdWRlIDxsaW51eC9lcnJuby5oPg0KI2luY2x1ZGUgPGxpbnV4
L2ZzLmg+DQojaW5jbHVkZSA8bGludXgvaW5pdC5oPg0KI2luY2x1ZGUgPGxpbnV4L3N0cmluZy5o
Pg0KI2luY2x1ZGUgPGxpbnV4L2ludGVycnVwdC5oPg0KI2luY2x1ZGUgPGxpbnV4L2RldmljZS5o
Pg0KI2luY2x1ZGUgPGxpbnV4L21pc2NkZXZpY2UuaD4NCiNpbmNsdWRlIDxsaW51eC9zcGkvc3Bp
Lmg+DQojaW5jbHVkZSA8bGludXgvc3BpbmxvY2suaD4NCiNpbmNsdWRlIDxsaW51eC9kbWEtbWFw
cGluZy5oPg0KDQojaW5jbHVkZSA8YXNtL2RtYS1tYXBwaW5nLmg+DQojaW5jbHVkZSA8YXNtL2lv
Lmg+DQojaW5jbHVkZSA8YXNtL2lycS5oPg0KI2luY2x1ZGUgPGFzbS9jYWNoZWZsdXNoLmg+DQoj
aW5jbHVkZSA8YXNtL2RtYS5oPg0KDQojaW5jbHVkZSAiYmVhZ2xlX3NwaS5oIg0KDQojZGVmaW5l
IFNQSTBfQURDX01JTk9SICAgICAgICAgMjUxDQoNCnN0cnVjdCBiZWFnbGVfc3BpX2FkYyB7DQoJ
aW50ICAgICAgICAgICAgIG9wZW5lZDsNCgl1bnNpZ25lZCBzaG9ydCAgKmJ1ZmZlcjsNCglpbnQg
ICAgICAgICAgICAgaHo7DQoJaW50IAkJY29udDsNCglzdHJ1Y3Qgc3BpX2RldmljZSAqc3BpZGV2
Ow0KCWRtYV9hZGRyX3QgZG1hX2hhbmRsZTsNCn07DQoNCnN0cnVjdCBiZWFnbGVfc3BpX2FkYyBz
cGlfYWRjOw0Kc3RhdGljIERFRklORV9TUElOTE9DSyhzcGlhZGNfbG9jayk7DQoNCnN0YXRpYyBp
bnQgYWRjX3NwaV9pb2N0bChzdHJ1Y3QgaW5vZGUgKmlub2RlLCBzdHJ1Y3QgZmlsZSAqZmlscCwg
dWludCBjbWQsIHVuc2lnbmVkIGxvbmcgYXJnKQ0Kew0KdW5zaWduZWQgbG9uZyB2YWx1ZTsNCnN0
cnVjdCBiZWFnbGVfc3BpX2FkYyAqYmVhZ2xlX3NwaV9hZGMgPSBmaWxwLT5wcml2YXRlX2RhdGE7
DQoNCnN3aXRjaCAoY21kKSB7DQpjYXNlIENNRF9TUElfR0VUX1NZU1RFTUNMT0NLOg0Kew0KdmFs
dWUgPSBnZXRfc2NsaygpOw0KY29weV90b191c2VyKCh1bnNpZ25lZCBsb25nICopYXJnLCAmdmFs
dWUsIHNpemVvZih1bnNpZ25lZCBsb25nKSk7DQpicmVhazsNCn0NCmNhc2UgQ01EX1NQSV9TRVRf
QkFVRFJBVEU6DQp7DQppZiAoYXJnID4gKDEzMzAwMDAwMCAvIDQpKQ0KcmV0dXJuIC1FSU5WQUw7
DQpiZWFnbGVfc3BpX2FkYy0+aHogPSBhcmc7DQpicmVhazsNCn0NCmNhc2UgQ01EX1NQSV9TRVRf
V1JJVEVDT05USU5VT1VTOg0Kew0KYmVhZ2xlX3NwaV9hZGMtPmNvbnQgPSAodW5zaWduZWQgY2hh
cilhcmc7DQpicmVhazsNCn0NCmRlZmF1bHQ6DQpyZXR1cm4gLUVJTlZBTDsNCn0NCnJldHVybiAw
Ow0KfQ0KDQpzdGF0aWMgc3NpemVfdCBhZGNfc3BpX3JlYWQgKHN0cnVjdCBmaWxlICpmaWxwLCBj
aGFyICpidWYsIHNpemVfdCBjb3VudCwgbG9mZl90ICpwb3MpDQp7DQppbnQgc3RhdDsNCnN0cnVj
dCBiZWFnbGVfc3BpX2FkYyAqYmVhZ2xlX3NwaV9hZGMgPSBmaWxwLT5wcml2YXRlX2RhdGE7DQp1
OCAqYnVmZmVyOw0KDQpzdHJ1Y3Qgc3BpX3RyYW5zZmVyCXQgPSB7DQoubGVuCQk9IGNvdW50LA0K
LnNwZWVkX2h6CT0gYmVhZ2xlX3NwaV9hZGMtPmh6LA0KfTsNCnN0cnVjdCBzcGlfbWVzc2FnZQlt
Ow0KDQppZiAoY291bnQgPD0gMCkNCnJldHVybiAtRUlOVkFMOw0KDQpidWZmZXIgPSBkbWFfYWxs
b2NfY29oZXJlbnQoTlVMTCwgY291bnQsICZiZWFnbGVfc3BpX2FkYy0+ZG1hX2hhbmRsZSwgR0ZQ
X0tFUk5FTCk7DQoNCmlmIChidWZmZXIgPT0gTlVMTCkNCnJldHVybiAtRU5PTUVNOw0KDQp0LnJ4
X2J1ZiA9IGJ1ZmZlcjsNCg0Kc3BpX21lc3NhZ2VfaW5pdCgmbSk7DQpzcGlfbWVzc2FnZV9hZGRf
dGFpbCgmdCwgJm0pOw0KDQpzdGF0ID0gc3BpX3N5bmMoYmVhZ2xlX3NwaV9hZGMtPnNwaWRldiwg
Jm0pOw0KDQppZiAoc3RhdCA9PSAwKSB7DQp1bnNpZ25lZCBsb25nCW1pc3Npbmc7DQoNCm1pc3Np
bmcgPSBjb3B5X3RvX3VzZXIoYnVmLCBidWZmZXIsIGNvdW50KTsNCmlmIChjb3VudCAmJiBtaXNz
aW5nID09IGNvdW50KQ0Kc3RhdCA9IC1FRkFVTFQ7DQplbHNlDQpzdGF0ID0gY291bnQgLSBtaXNz
aW5nOw0KfQ0KDQpkbWFfZnJlZV9jb2hlcmVudChOVUxMLCBjb3VudCwgYnVmZmVyLCBiZWFnbGVf
c3BpX2FkYy0+ZG1hX2hhbmRsZSk7DQoNCnJldHVybiBzdGF0Ow0KfQ0KDQpzdGF0aWMgc3NpemVf
dCBhZGNfc3BpX3dyaXRlIChzdHJ1Y3QgZmlsZSAqZmlscCwgY29uc3QgY2hhciAqYnVmLCBzaXpl
X3QgY291bnQsIGxvZmZfdCAqZl9wb3MpDQp7DQppbnQgc3RhdDsNCnVuc2lnbmVkIGxvbmcgbWlz
c2luZzsNCnN0cnVjdCBiZWFnbGVfc3BpX2FkYyAqYmVhZ2xlX3NwaV9hZGMgPSBmaWxwLT5wcml2
YXRlX2RhdGE7DQp1OCAqYnVmZmVyOw0KDQpzdHJ1Y3Qgc3BpX3RyYW5zZmVyCXQgPSB7DQoubGVu
CQk9IGNvdW50LA0KLnNwZWVkX2h6CT0gYmVhZ2xlX3NwaV9hZGMtPmh6LA0KfTsNCnN0cnVjdCBz
cGlfbWVzc2FnZQltOw0KDQppZiAoY291bnQgPD0gMCkNCnJldHVybiAtRUlOVkFMOw0KDQpidWZm
ZXIgPSBkbWFfYWxsb2NfY29oZXJlbnQoTlVMTCwgY291bnQsICZiZWFnbGVfc3BpX2FkYy0+ZG1h
X2hhbmRsZSwgR0ZQX0tFUk5FTCk7DQoNCmlmIChidWZmZXIgPT0gTlVMTCkNCnJldHVybiAtRU5P
TUVNOw0KDQp0LnR4X2J1ZiA9IGJ1ZmZlcjsNCg0KaWYgKGJlYWdsZV9zcGlfYWRjLT5jb250KQ0K
dC50eF9kbWEgPSAweEZGRkY7DQoNCnNwaV9tZXNzYWdlX2luaXQoJm0pOw0Kc3BpX21lc3NhZ2Vf
YWRkX3RhaWwoJnQsICZtKTsNCg0KbWlzc2luZyA9IGNvcHlfZnJvbV91c2VyKGJ1ZmZlciwgYnVm
LCBjb3VudCk7DQoNCmlmIChtaXNzaW5nID09IDApIHsNCnN0YXQgPSBzcGlfc3luYyhiZWFnbGVf
c3BpX2FkYy0+c3BpZGV2LCAmbSk7DQppZiAoc3RhdCA9PSAwKQ0Kc3RhdCA9IGNvdW50Ow0KfSAN
CmVsc2UNCnN0YXQgPSAtRUZBVUxUOw0KDQpkbWFfZnJlZV9jb2hlcmVudChOVUxMLCBjb3VudCwg
YnVmZmVyLCBiZWFnbGVfc3BpX2FkYy0+ZG1hX2hhbmRsZSk7DQoNCnJldHVybiBzdGF0Ow0KfQ0K
DQpzdGF0aWMgaW50IGFkY19zcGlfb3BlbihzdHJ1Y3QgaW5vZGUgKmlub2RlLCBzdHJ1Y3QgZmls
ZSAqZmlscCkNCnsNCnVuc2lnbmVkIGxvbmcgZmxhZ3M7DQppbnQgbWlub3IgPSBNSU5PUiAoaW5v
ZGUtPmlfcmRldik7DQoNCg0KaWYgKG1pbm9yICE9IFNQSTBfQURDX01JTk9SKQ0KcmV0dXJuIC1F
TlhJTzsNCg0Kc3Bpbl9sb2NrX2lycXNhdmUoJnNwaWFkY19sb2NrLCBmbGFncyk7DQppZiAoc3Bp
X2FkYy5vcGVuZWQpew0Kc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgmc3BpYWRjX2xvY2ssIGZsYWdz
KTsNCnJldHVybiAtRU1GSUxFOw0KfQ0KDQpzcGlfYWRjLm9wZW5lZCA9IDE7DQoNCmZpbHAtPnBy
aXZhdGVfZGF0YSA9ICZzcGlfYWRjOw0Kc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgmc3BpYWRjX2xv
Y2ssIGZsYWdzKTsNCg0KcmV0dXJuIDA7DQp9DQoNCnN0YXRpYyBpbnQgYWRjX3NwaV9yZWxlYXNl
IChzdHJ1Y3QgaW5vZGUgKmlub2RlLCBzdHJ1Y3QgZmlsZSAqZmlscCkNCnsNCnVuc2lnbmVkIGxv
bmcgZmxhZ3M7DQpzdHJ1Y3QgYmVhZ2xlX3NwaV9hZGMgKmJlYWdsZV9zcGlfYWRjID0gZmlscC0+
cHJpdmF0ZV9kYXRhOw0KDQpzcGluX2xvY2tfaXJxc2F2ZSgmc3BpYWRjX2xvY2ssIGZsYWdzKTsN
CmJlYWdsZV9zcGlfYWRjLT5vcGVuZWQgPSAwOw0KYmVhZ2xlX3NwaV9hZGMtPmh6ID0gMDsNCmJl
YWdsZV9zcGlfYWRjLT5jb250ID0gMDsNCnNwaW5fdW5sb2NrX2lycXJlc3RvcmUoJnNwaWFkY19s
b2NrLCBmbGFncyk7DQoNCnJldHVybiAwOw0KfQ0KDQpzdGF0aWMgc3RydWN0IGZpbGVfb3BlcmF0
aW9ucyBiZWFnbGVfc3BpX2FkY19mb3BzID0gew0KLm93bmVyID0gVEhJU19NT0RVTEUsDQoucmVh
ZCA9IGFkY19zcGlfcmVhZCwNCi53cml0ZSA9IGFkY19zcGlfd3JpdGUsDQouaW9jdGwgPSBhZGNf
c3BpX2lvY3RsLA0KLm9wZW4gPSBhZGNfc3BpX29wZW4sDQoucmVsZWFzZSA9IGFkY19zcGlfcmVs
ZWFzZSwNCn07DQoNCnN0YXRpYyBpbnQgX19kZXZpbml0IGJlYWdsZV9zcGlfYWRjX3Byb2JlKHN0
cnVjdCBzcGlfZGV2aWNlICpzcGkpDQp7DQpzcGlfYWRjLnNwaWRldiA9IHNwaTsNCg0KcmV0dXJu
IDA7DQp9DQoNCnN0YXRpYyBpbnQgX19kZXZleGl0IGJlYWdsZV9zcGlfYWRjX3JlbW92ZShzdHJ1
Y3Qgc3BpX2RldmljZSAqc3BpKQ0Kew0KcHJpbnRrKEtFUk5fSU5GTyAiR29vZGJ5ZSBTUElcbiIp
Ow0KcmV0dXJuIDA7DQp9DQoNCnN0YXRpYyBzdHJ1Y3Qgc3BpX2RyaXZlciBiZWFnbGVfc3BpX2Fk
Y19kcml2ZXIgPSB7DQouZHJpdmVyID0gew0KLm5hbWUJPSAiYmVhZ2xlX3NwaV9hZGMiLA0KLmJ1
cwk9ICZzcGlfYnVzX3R5cGUsDQoub3duZXIJPSBUSElTX01PRFVMRSwNCn0sDQoucHJvYmUJPSBi
ZWFnbGVfc3BpX2FkY19wcm9iZSwNCi5yZW1vdmUJPSBfX2RldmV4aXRfcChiZWFnbGVfc3BpX2Fk
Y19yZW1vdmUpLA0KfTsNCg0KLypzdGF0aWMgc3RydWN0IG1pc2NkZXZpY2UgYmVhZ2xlX2FkY19k
ZXYgPSB7DQpTUEkwX0FEQ19NSU5PUiwNCiJzcGkiLA0KJmJlYWdsZV9zcGlfYWRjX2ZvcHMNCn07
Ki8NCg0Kc3RhdGljIGludCBfX2luaXQgYmVhZ2xlX3NwaV9hZGNfaW5pdCh2b2lkKQ0Kew0KaW50
IHJlc3VsdDsNCnJlc3VsdCA9IG1pc2NfcmVnaXN0ZXIoJmJlYWdsZV9hZGNfZGV2KTsNCmlmIChy
ZXN1bHQgPCAwKSB7DQpwcmludGsoS0VSTl9XQVJOSU5HICJTUEk6IEZhaWxlZCB0byByZWdpc3Rl
clxuIik7DQpyZXR1cm4gcmVzdWx0Ow0KfQ0KDQpyZXR1cm4gc3BpX3JlZ2lzdGVyX2RyaXZlcigm
YmVhZ2xlX3NwaV9hZGNfZHJpdmVyKTsNCn0NCg0Kc3RhdGljIHZvaWQgX19leGl0IGJlYWdsZV9z
cGlfYWRjX2V4aXQodm9pZCkNCnsNCnNwaV91bnJlZ2lzdGVyX2RyaXZlcigmYmVhZ2xlX3NwaV9h
ZGNfZHJpdmVyKTsNCm1pc2NfZGVyZWdpc3RlcigmYmVhZ2xlX2FkY19kZXYpOw0KfQ0KDQptb2R1
bGVfaW5pdChiZWFnbGVfc3BpX2FkY19pbml0KTsNCm1vZHVsZV9leGl0KGJlYWdsZV9zcGlfYWRj
X2V4aXQpOw0KDQpNT0RVTEVfTElDRU5TRSgiR1BMIik7DQpNT0RVTEVfREVTQ1JJUFRJT04oIlNQ
SS1BREMgRHJpdmVyIik7
--0016364d20a7369417046848c97c
Content-Type: application/octet-stream; name="bfin5xx_spi.h"
Content-Disposition: attachment; filename="bfin5xx_spi.h"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_ftwmf21a1

I2lmbmRlZiBfU1BJX0NIQU5ORUxfSF8NCiNkZWZpbmUgX1NQSV9DSEFOTkVMX0hfDQoNCiNkZWZp
bmUgU1BJX1JFQUQgICAgICAgICAgICAgIDANCiNkZWZpbmUgU1BJX1dSSVRFICAgICAgICAgICAg
IDENCg0KI2RlZmluZSBTUElfQ1RSTF9PRkYgICAgICAgICAgICAweDANCiNkZWZpbmUgU1BJX0ZM
QUdfT0ZGICAgICAgICAgICAgMHg0DQojZGVmaW5lIFNQSV9TVEFUX09GRiAgICAgICAgICAgIDB4
OA0KI2RlZmluZSBTUElfVFhCVUZGX09GRiAgICAgICAgICAweGMNCiNkZWZpbmUgU1BJX1JYQlVG
Rl9PRkYgICAgICAgICAgMHgxMA0KI2RlZmluZSBTUElfQkFVRF9PRkYgICAgICAgICAgICAweDE0
DQojZGVmaW5lIFNQSV9TSEFXX09GRiAgICAgICAgICAgIDB4MTgNCg0KDQojZGVmaW5lIEJJVF9D
VExfRU5BQkxFICAgICAgMHg0MDAwDQojZGVmaW5lIEJJVF9DVExfT1BFTkRSQUlOICAgMHgyMDAw
DQojZGVmaW5lIEJJVF9DVExfTUFTVEVSICAgICAgMHgxMDAwDQojZGVmaW5lIEJJVF9DVExfUE9M
QVIgICAgICAgMHgwODAwDQojZGVmaW5lIEJJVF9DVExfUEhBU0UgICAgICAgMHgwNDAwDQojZGVm
aW5lIEJJVF9DVExfQklUT1JERVIgICAgMHgwMjAwDQojZGVmaW5lIEJJVF9DVExfV09SRFNJWkUg
ICAgMHgwMTAwDQojZGVmaW5lIEJJVF9DVExfTUlTT0VOQUJMRSAgMHgwMDIwDQojZGVmaW5lIEJJ
VF9DVExfUlhNT0QgICAgICAgMHgwMDAwDQojZGVmaW5lIEJJVF9DVExfVFhNT0QgICAgICAgMHgw
MDAxDQojZGVmaW5lIEJJVF9DVExfVElNT0RfRE1BX1RYIDB4MDAwMw0KI2RlZmluZSBCSVRfQ1RM
X1RJTU9EX0RNQV9SWCAweDAwMDINCiNkZWZpbmUgQklUX0NUTF9TRU5ET1BUICAgICAweDAwMDQN
CiNkZWZpbmUgQklUX0NUTF9USU1PRCAgICAgICAweDAwMDMNCg0KI2RlZmluZSBCSVRfU1RBVF9T
UElGICAgICAgIDB4MDAwMQ0KI2RlZmluZSBCSVRfU1RBVF9NT0RGICAgICAgIDB4MDAwMg0KI2Rl
ZmluZSBCSVRfU1RBVF9UWEUgICAgICAgIDB4MDAwNA0KI2RlZmluZSBCSVRfU1RBVF9UWFMgICAg
ICAgIDB4MDAwOA0KI2RlZmluZSBCSVRfU1RBVF9SQlNZICAgICAgIDB4MDAxMA0KI2RlZmluZSBC
SVRfU1RBVF9SWFMgICAgICAgIDB4MDAyMA0KI2RlZmluZSBCSVRfU1RBVF9UWENPTCAgICAgIDB4
MDA0MA0KI2RlZmluZSBCSVRfU1RBVF9DTFIgICAgICAgIDB4RkZGRg0KDQojZGVmaW5lIEJJVF9T
VFVfU0VORE9WRVIgICAgMHgwMDAxDQojZGVmaW5lIEJJVF9TVFVfUkVDVkZVTEwgICAgMHgwMDIw
DQoNCiNkZWZpbmUgQ0ZHX1NQSV9FTkFCTEUgICAgICAxDQojZGVmaW5lIENGR19TUElfRElTQUJM
RSAgICAgMA0KDQojZGVmaW5lIENGR19TUElfT1VURU5BQkxFICAgMQ0KI2RlZmluZSBDRkdfU1BJ
X09VVERJU0FCTEUgIDANCg0KI2RlZmluZSBDRkdfU1BJX0FDVExPVyAgICAgIDENCiNkZWZpbmUg
Q0ZHX1NQSV9BQ1RISUdIICAgICAwDQoNCiNkZWZpbmUgQ0ZHX1NQSV9QSEFTRVNUQVJUICAxDQoj
ZGVmaW5lIENGR19TUElfUEhBU0VNSUQgICAgMA0KDQojZGVmaW5lIENGR19TUElfTUFTVEVSICAg
ICAgMQ0KI2RlZmluZSBDRkdfU1BJX1NMQVZFICAgICAgIDANCg0KI2RlZmluZSBDRkdfU1BJX1NF
TkVMQVNUICAgIDANCiNkZWZpbmUgQ0ZHX1NQSV9TRU5EWkVSTyAgICAxDQoNCiNkZWZpbmUgQ0ZH
X1NQSV9SQ1ZGTFVTSCAgICAxDQojZGVmaW5lIENGR19TUElfUkNWRElTQ0FSRCAgMA0KDQojZGVm
aW5lIENGR19TUElfTFNCRklSU1QgICAgMQ0KI2RlZmluZSBDRkdfU1BJX01TQkZJUlNUICAgIDAN
Cg0KI2RlZmluZSBDRkdfU1BJX1dPUkRTSVpFMTYgIDENCiNkZWZpbmUgQ0ZHX1NQSV9XT1JEU0la
RTggICAwDQoNCiNkZWZpbmUgQ0ZHX1NQSV9NSVNPRU5BQkxFICAgMQ0KI2RlZmluZSBDRkdfU1BJ
X01JU09ESVNBQkxFICAwDQoNCiNkZWZpbmUgQ0ZHX1NQSV9SRUFEICAgICAgMHgwMA0KI2RlZmlu
ZSBDRkdfU1BJX1dSSVRFICAgICAweDAxDQojZGVmaW5lIENGR19TUElfRE1BUkVBRCAgIDB4MDIN
CiNkZWZpbmUgQ0ZHX1NQSV9ETUFXUklURSAgMHgwMw0KDQojZGVmaW5lIENGR19TUElfQ1NDTEVB
UkFMTCAgMA0KI2RlZmluZSBDRkdfU1BJX0NISVBTRUwxICAgIDENCiNkZWZpbmUgQ0ZHX1NQSV9D
SElQU0VMMiAgICAyDQojZGVmaW5lIENGR19TUElfQ0hJUFNFTDMgICAgMw0KI2RlZmluZSBDRkdf
U1BJX0NISVBTRUw0ICAgIDQNCiNkZWZpbmUgQ0ZHX1NQSV9DSElQU0VMNSAgICA1DQojZGVmaW5l
IENGR19TUElfQ0hJUFNFTDYgICAgNg0KI2RlZmluZSBDRkdfU1BJX0NISVBTRUw3ICAgIDcNCg0K
I2RlZmluZSBDRkdfU1BJX0NTMVZBTFVFICAgIDENCiNkZWZpbmUgQ0ZHX1NQSV9DUzJWQUxVRSAg
ICAyDQojZGVmaW5lIENGR19TUElfQ1MzVkFMVUUgICAgMw0KI2RlZmluZSBDRkdfU1BJX0NTNFZB
TFVFICAgIDQNCiNkZWZpbmUgQ0ZHX1NQSV9DUzVWQUxVRSAgICA1DQojZGVmaW5lIENGR19TUElf
Q1M2VkFMVUUgICAgNg0KI2RlZmluZSBDRkdfU1BJX0NTN1ZBTFVFICAgIDcNCg0KI2RlZmluZSBD
TURfU1BJX1NFVF9CQVVEUkFURSAgMg0KI2RlZmluZSBDTURfU1BJX0dFVF9TWVNURU1DTE9DSyAg
IDI1DQojZGVmaW5lIENNRF9TUElfU0VUX1dSSVRFQ09OVElOVU9VUyAgICAgMjYNCg0Kc3RydWN0
IGJlYWdsZV9zcGlfbWFzdGVyIHsNCnUxNiBudW1fY2hpcHNlbGVjdDsNCnU4IGVuYWJsZV9kbWE7
DQp1MTYgcGluX3JlcVs0XTsNCn07DQoNCnN0cnVjdCBiZWFnbGVfc3BpX2NoaXAgew0KdTE2IGN0
bF9yZWc7DQp1OCBlbmFibGVfZG1hOw0KdTggYml0c19wZXJfd29yZDsNCnU4IGNzX2NoYW5nZV9w
ZXJfd29yZDsNCnUxNiBjc19jaGdfdWRlbGF5Ow0KfTsNCg0KI2VuZGlm
--0016364d20a7369417046848c97c
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
--0016364d20a7369417046848c97c
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
spi-devel-general mailing list
spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
https://lists.sourceforge.net/lists/listinfo/spi-devel-general

--0016364d20a7369417046848c97c--
