From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [PATCH] spi: tegra114: add spi driver
Date: Wed, 20 Feb 2013 10:36:41 -0700
Message-ID: <512509A9.6020208@wwwdotorg.org>
References: <1361281115-20436-1-git-send-email-ldewangan@nvidia.com> <5123C18A.9010604@wwwdotorg.org> <5124C18F.6070108@nvidia.com> <20130220131112.GE2726@opensource.wolfsonmicro.com> <5124CEF5.3060605@nvidia.com> <512506F9.2030508@wwwdotorg.org> <20130220173109.GU2726@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>,
	"grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org" <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>,
	"rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org" <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>,
	"linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org"
	<devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>,
	"linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org"
	<spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	"linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
To: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20130220173109.GU2726-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On 02/20/2013 10:31 AM, Mark Brown wrote:
> On Wed, Feb 20, 2013 at 10:25:13AM -0700, Stephen Warren wrote:
> 
>> But, please do think this approach through fully. The DT binding
>> needs to define which clock-names the driver requires to be
>> present, and any optional clock names. DT bindings are supposed
>> to be immutable, or perhaps extendible in a completely
>> backwards-compatible fashion. This implies that you need to have
>> thought through the entire list of clocks that the driver might
>> want in the DT clock-names property when you first write the DT
>> binding documentation...
> 
> Since we can extend the list of clocks it doesn't seem like there's
> much issue here, especially if some of them are optional?

Yes, there's certainly a way to extend the binding in a
backwards-compatible way.

However, I have seen in Rob and/or Grant push back on not fully
defining bindings in the past - i.e. actively planning to initially
create a minimal binding and extend it in the future, rather than
completely defining it up-front.

I don't know how strong of a rule they intend that to be though. If we
get to the point of moving the DT bindings out of the kernel, it'd be
good to get a concrete definition of what can and can't be changed in
bindings.

> Though in general it seems like this sort of mux really should be
> in the clock stuff anyway.

How do you see that working: something automatic inside clk_set_rate()
seeing that some other parent could provide the rate, so the clock
could be reparented, or ...?
