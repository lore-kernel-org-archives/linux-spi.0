From: Colin Cross <ccross-z5hGa2qSFaRBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 1/2] gpio/tegra: Move Tegra gpio driver to drivers/gpio
Date: Wed, 15 Jun 2011 14:02:23 -0700
Message-ID: <BANLkTik2YfpxJvHjiGOqvqPj7U2rhq-RyPTKHpWHU1BMCSrWJw@mail.gmail.com>
References: <20110615193734.23641.8004.stgit@ponder>
	<BANLkTinij15PZw11Y3Qt=PV1kkP1pw1oaszTdMfD55Cf8cOJkw@mail.gmail.com>
	<BANLkTik6C1mBeitYkA+NNM6XAhNY9cbgOw@mail.gmail.com>
	<BANLkTik4fna_C-1JHt9KoF4UsYCuqVy6Nw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Erik Gilling <konkers-z5hGa2qSFaRBDgjK7y7TUQ@public.gmane.org>,
	lkml <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	linux-tegra <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	"linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org"
	<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <BANLkTik4fna_C-1JHt9KoF4UsYCuqVy6Nw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Wed, Jun 15, 2011 at 2:00 PM, Grant Likely <grant.likely@secretlab.c=
a> wrote:
> On Wed, Jun 15, 2011 at 2:48 PM, Grant Likely <grant.likely@secretlab=
=2Eca> wrote:
>> On Wed, Jun 15, 2011 at 2:21 PM, Colin Cross <ccross-z5hGa2qSFaRBDgjK7y7TUQ@public.gmane.org> wr=
ote:
>>> On Wed, Jun 15, 2011 at 12:37 PM, Grant Likely
>>> <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org> wrote:
>>>> As part of the gpio driver consolidation, this patch moves the Teg=
ra driver
>>>> into drivers/gpio
>>>>
>>>> Signed-off-by: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
>>>> ---
>>>>
>>>> If there are no objections, I'll merge this via gpio/next
>>>
>>> I have this patch as part of a series that should get posted later
>>> this week, as well as a patch on top of it that depends on this cha=
nge
>>> and another change in my tree, but I'm pessimistic that my series w=
ill
>>> get in to 3.1 since it depends on some common consolidation that
>>> hasn't been agreed upon yet. =A0So,
>>> Acked-by: Colin Cross <ccross-z5hGa2qSFaRBDgjK7y7TUQ@public.gmane.org>
>>>
>>> Put it in gpio/next, and I'll make sure any other Tegra patches wit=
h
>>> dependencies get pulled after yours.
>>
>> How about I put it in a separate branch so that if you need to pull =
it
>> for dependencies then you can do so without pulling in all the
>> gpio/next commits.
>
> I've pushed it out to the following branch. =A0If everything looks ok=
ay
> to you, then I'll merge it into gpio/next and push it out.
>
> The following changes since commit 2c53b436a30867eb6b47dd7bab23ba638d=
1fb0d2:
>
> =A0Linux 3.0-rc3 (2011-06-13 15:29:59 -0700)
>
> are available in the git repository at:
> =A0git://git.secretlab.ca/git/linux-2.6 gpio/next-tegra
>
> Grant Likely (2):
> =A0 =A0 =A0gpio/tegra: Move Tegra gpio driver to drivers/gpio
> =A0 =A0 =A0gpio/tegra: add devicetree support
>
> =A0.../devicetree/bindings/gpio/gpio_nvidia.txt =A0 =A0 =A0 | =A0 =A0=
7 +++++++
> =A0arch/arm/mach-tegra/Makefile =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 | =A0 =A01 -
> =A0drivers/gpio/Makefile =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0| =A0 =A01 +
> =A0.../mach-tegra/gpio.c =3D> drivers/gpio/gpio-tegra.c | =A0 10 ++++=
++++++
> =A04 files changed, 18 insertions(+), 1 deletions(-)
> =A0create mode 100644 Documentation/devicetree/bindings/gpio/gpio_nvi=
dia.txt
> =A0rename arch/arm/mach-tegra/gpio.c =3D> drivers/gpio/gpio-tegra.c (=
97%)
>

Thanks, that sounds good.
