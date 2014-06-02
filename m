From: Darren Hart <dvhart-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH 2/2] clkdev: Export clk_register_clkdev
Date: Mon, 02 Jun 2014 08:16:08 -0700
Message-ID: <CFB1E2EA.94DEE%dvhart@linux.intel.com>
References: <1401738379-4107-1-git-send-email-chiau.ee.chew@intel.com>
 <1401738379-4107-3-git-send-email-chiau.ee.chew@intel.com>
 <20140602123522.GB31751@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Cc: Eric Miao <eric.y.miao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>,
	Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	<linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Chew Chiau Ee <chiau.ee.chew-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140602123522.GB31751-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On 6/2/14, 5:35, "Mark Brown" <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:

>On Tue, Jun 03, 2014 at 03:46:19AM +0800, Chew Chiau Ee wrote:
>> From: Darren Hart <dvhart-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
>> 
>> Allow spi-pxa2xx-pci with common clock framework support to build as a
>> module by exporting clk_register_clkdev.
>
>This needs to be patch 1 in the series not patch 2 since the change to
>the driver to use the exported symbol depends on this rather than the
>other way around.
>

That was going to be my only comment as well. It's important to ensure
things build consistently through the git history. Git bisect is a key use
case here, breaking that makes for very cranky kernel engineers :-)
Dependencies first, new mechanisms second.

-- 
Darren Hart					Open Source Technology Center
darren.hart-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org				            Intel Corporation



--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
