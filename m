From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH v2] spi: New driver for Altera SPI
Date: Sun, 16 Jan 2011 23:45:51 -0700
Message-ID: <AANLkTi=D4Rcxbei2oo+EHc6X1O-2Oo+VWHAasK_JLj5W@mail.gmail.com>
References: <1254981838-20584-1-git-send-email-thomas@wytron.com.tw>
	<1295243200-28230-1-git-send-email-thomas@wytron.com.tw>
	<20110117165958.f89e8220.sfr@canb.auug.org.au>
	<4D33E00E.5050802@wytron.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Stephen Rothwell <sfr-3FnU+UHB4dNDw9hX6IcOSA@public.gmane.org>, nios2-dev-1eJk0qcHJCcaeqlQEoCUNoJY59XmG8rH@public.gmane.org,
	David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	Mike Frysinger <vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Thomas Chou <thomas-SDxUXYEhEBiCuPEqFHbRBg@public.gmane.org>
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <4D33E00E.5050802-SDxUXYEhEBiCuPEqFHbRBg@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
	<mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
	<mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Sender: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Sun, Jan 16, 2011 at 11:22 PM, Thomas Chou <thomas-SDxUXYEhEBiCuPEqFHbRBg@public.gmane.org> wrote:
> On 01/17/2011 01:59 PM, Stephen Rothwell wrote:
>>>
>>> +/*
>>> + * struct altera_spi_platform_data - platform data of the Altera SPI
>>> + * @interrupt: use intrrupt driven data transfer.
>>> + */
>>> +struct altera_spi_platform_data {
>>> +       int interrupt;
>>> +};
>>
>> Is there some reason that this struct definition cannot just be placed
>> in spi_altera.c and so save a whole extra file (and its inclusion)?
>>
>
> Hi Stephen,
>
> It is needed for board configuration file to attach this platform data,
> which is used to choose between interrupt driven data transfer or polling
> method. The data transfer rate is usually faster for polling, as interrupt
> overhead is higher.

In this case, that decision could simply be made based on whether or
not the device has an irq resource.  No irq == polled mode.

g.
