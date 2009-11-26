From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] spi: Allow using spi_bitbang_setup() with custom
	txrx_bufs()
Date: Thu, 26 Nov 2009 00:21:29 -0700
Message-ID: <fa686aa40911252321t3111a8e8w9afc22ef1f262424@mail.gmail.com>
References: <20091125082603.25618.57438.sendpatchset@rxone.opensource.se>
	<fa686aa40911251415q624f3610n92cbc20437b12bf6@mail.gmail.com>
	<aec7e5c30911252247i344f5bf3pb0240b9c23878bf5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: spi-devel-general@lists.sourceforge.net,
	dbrownell@users.sourceforge.net, linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org
To: Magnus Damm <magnus.damm@gmail.com>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753333AbZKZHVo@vger.kernel.org>
In-Reply-To: <aec7e5c30911252247i344f5bf3pb0240b9c23878bf5@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Wed, Nov 25, 2009 at 11:47 PM, Magnus Damm <magnus.damm@gmail.com> w=
rote:
> Hi Grant,
>
> On Thu, Nov 26, 2009 at 7:15 AM, Grant Likely <grant.likely@secretlab=
=2Eca> wrote:
>> On Wed, Nov 25, 2009 at 1:26 AM, Magnus Damm <magnus.damm@gmail.com>=
 wrote:
>>> =A0 =A0 =A0 =A0/* per-word shift register access, in hardware or bi=
tbanging */
>>> - =A0 =A0 =A0 cs->txrx_word =3D bitbang->txrx_word[spi->mode & (SPI=
_CPOL|SPI_CPHA)];
>>> - =A0 =A0 =A0 if (!cs->txrx_word)
>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>>> + =A0 =A0 =A0 if (bitbang->txrx_bufs =3D=3D spi_bitbang_bufs) {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 cs->txrx_word =3D bitbang->txrx_word[=
spi->mode & mode_mask];
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!cs->txrx_word)
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>>> + =A0 =A0 =A0 }
>>
>> Hmmm... this smells like an ugly hack to me. =A0It seems to me that =
if
>> some bitbang backend drivers don't want this code, then it should be
>> encoded into a callback so it can be overridden. =A0Thoughts.
>
> Yeah, it's far from clean. I want to make use of spi_bitbang_setup()
> in my MSIOF driver, but I want to avoid dummy txtx_word[] callbacks
> that will be unused since i'm using a driver specific
> bitbang->txrx_bufs function.
>
> I guess the attached patch is slightly cleaner? I like the idea of
> letting bitbang drivers use shared code for
> spi_bitbang_setup()/spi_bitbang_cleanup() with their private
> setup_transfer() function which in turn calls
> spi_bitbang_setup_transfer(). My impression is that there's quite a
> bit of duplicated setup()/cleanup() code.

This is certainly less ugly.  But with the points brought up in the
other thread, I want to have a close look at spi-bitbang before I
start applying stuff.  It seems nasty.  Give me a few days.

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
