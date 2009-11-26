From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] spi: Allow using spi_bitbang_setup() with custom
	txrx_bufs()
Date: Thu, 26 Nov 2009 07:45:51 -0700
Message-ID: <fa686aa40911260645i50bf0c35g93b4146952a5f82e@mail.gmail.com>
References: <20091125082603.25618.57438.sendpatchset@rxone.opensource.se>
	<fa686aa40911251415q624f3610n92cbc20437b12bf6@mail.gmail.com>
	<aec7e5c30911252247i344f5bf3pb0240b9c23878bf5@mail.gmail.com>
	<fa686aa40911252321t3111a8e8w9afc22ef1f262424@mail.gmail.com>
	<aec7e5c30911252350r717393e8sd476fa7e3aeb301f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: spi-devel-general@lists.sourceforge.net,
	dbrownell@users.sourceforge.net, linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org
To: Magnus Damm <magnus.damm@gmail.com>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1760572AbZKZOqQ@vger.kernel.org>
In-Reply-To: <aec7e5c30911252350r717393e8sd476fa7e3aeb301f@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Thu, Nov 26, 2009 at 12:50 AM, Magnus Damm <magnus.damm@gmail.com> w=
rote:
> On Thu, Nov 26, 2009 at 4:21 PM, Grant Likely <grant.likely@secretlab=
=2Eca> wrote:
>> On Wed, Nov 25, 2009 at 11:47 PM, Magnus Damm <magnus.damm@gmail.com=
> wrote:
>>> On Thu, Nov 26, 2009 at 7:15 AM, Grant Likely <grant.likely@secretl=
ab.ca> wrote:
>>>> On Wed, Nov 25, 2009 at 1:26 AM, Magnus Damm <magnus.damm@gmail.co=
m> wrote:
>>>>> =A0 =A0 =A0 =A0/* per-word shift register access, in hardware or =
bitbanging */
>>>>> - =A0 =A0 =A0 cs->txrx_word =3D bitbang->txrx_word[spi->mode & (S=
PI_CPOL|SPI_CPHA)];
>>>>> - =A0 =A0 =A0 if (!cs->txrx_word)
>>>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>>>>> + =A0 =A0 =A0 if (bitbang->txrx_bufs =3D=3D spi_bitbang_bufs) {
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 cs->txrx_word =3D bitbang->txrx_wor=
d[spi->mode & mode_mask];
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!cs->txrx_word)
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>>>>> + =A0 =A0 =A0 }
>>>>
>>>> Hmmm... this smells like an ugly hack to me. =A0It seems to me tha=
t if
>>>> some bitbang backend drivers don't want this code, then it should =
be
>>>> encoded into a callback so it can be overridden. =A0Thoughts.
>>>
>>> Yeah, it's far from clean. I want to make use of spi_bitbang_setup(=
)
>>> in my MSIOF driver, but I want to avoid dummy txtx_word[] callbacks
>>> that will be unused since i'm using a driver specific
>>> bitbang->txrx_bufs function.
>>>
>>> I guess the attached patch is slightly cleaner? I like the idea of
>>> letting bitbang drivers use shared code for
>>> spi_bitbang_setup()/spi_bitbang_cleanup() with their private
>>> setup_transfer() function which in turn calls
>>> spi_bitbang_setup_transfer(). My impression is that there's quite a
>>> bit of duplicated setup()/cleanup() code.
>>
>> This is certainly less ugly. =A0But with the points brought up in th=
e
>> other thread, I want to have a close look at spi-bitbang before I
>> start applying stuff. =A0It seems nasty. =A0Give me a few days.
>
> Sure, I plan on posting a V2 of the MSIOF driver. I plan to keep the
> dummy txrx_word() function for now - this to disconnect the cleanup
> from the driver integration, hope that sounds like a good plan.

Works for me.  Now I just need to find someone with the time to
refactor spi-bitbang.  :-)

g.




--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
