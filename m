From: Andrea Adami <andrea.adami@gmail.com>
Subject: Re: [PATCH v2] spi/pxa2xx-pci: Add common clock framework support in
 PCI glue layer
Date: Tue, 29 Jul 2014 18:13:06 +0200
Message-ID: <CAAQYJAtM79NJJtfNYda-yFk113nm-2D8gZE5x=gbnLt2_eUdzQ@mail.gmail.com>
References: <1406221854-12828-1-git-send-email-chiau.ee.chew@intel.com>
	<20140725053230.GT1857@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: chiau.ee.chew@intel.com,
	Kweh Hock Leong <hock.leong.kweh@intel.com>,
	Russell King <linux@arm.linux.org.uk>,
	Darren Hart <dvhart@linux.intel.com>, chiauee85@gmail.com,
	linux-kernel@vger.kernel.org,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>,
	Eric Miao <eric.y.miao@gmail.com>,
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140725053230.GT1857@lahna.fi.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Fri, Jul 25, 2014 at 7:32 AM, Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
> On Fri, Jul 25, 2014 at 01:10:54AM +0800, chiau.ee.chew@intel.com wrote:
>> From: Chew, Chiau Ee <chiau.ee.chew@intel.com>
>>
>> SPI PXA2XX core layer has dependency on common clock framework
>> to obtain information on host supported clock rate. Thus, we
>> setup the clock device in the PCI glue layer to enable PCI mode
>> host pass in the clock rate information.
>>
>> Signed-off-by: Chew, Chiau Ee <chiau.ee.chew@intel.com>
>> Acked-by: Kweh, Hock Leong <hock.leong.kweh@intel.com>
>
> Looks reasonable,
>
> Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

Hi,

note that a previous version of the patch breaks spi on pxa machines:
tested on pxa250 poodle and pxa255 corgi.
The patch is included in linux-Yocto since 3.14.

The evident error is the absence of the touchscreen and on corgi a total crash.
pxa2xx-spi: probe of pxa2xx-spi.1 failed with error -2

I sent the full logs to the pxa maintainers.
Please let me know if there are any trivial fixes to apply on the top
of this patch for the non-pci, non-DT boards or better workarounds.

Thanks

Andrea
