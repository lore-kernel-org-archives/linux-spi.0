From: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Subject: Re: [PATCH] spi: remove completely broken Tegra driver
Date: Mon, 1 Oct 2012 11:20:55 +0100
Message-ID: <20121001102055.GD4360@opensource.wolfsonmicro.com>
References: <1348848948-21795-1-git-send-email-swarren@wwwdotorg.org>
 <50696555.1050509@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>,
	Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>,
	"spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org"
	<spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	"linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
To: Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <50696555.1050509-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Mon, Oct 01, 2012 at 03:11:41PM +0530, Laxman Dewangan wrote:

> It will be great if this goes in k3.7 so that we can post the new
> driver on K3.8.

Why would this make any difference to the ability to post a new version?

I do wish stop making up version numbers, it's very irritating.  I
suppose at least people are now including the actual number rather than
the "K32" stuff we used to get :/

> Definitely it will easy to review along with multiple bug fixes
> which is done in driver for interfacing different devices like
> camera/ touch etc.
> Having all these changes on top of existing one will create more
> than 10 patches and complicate the review. Also after these many
> patches, the new driver will be look different than the existing
> one.

You can always just post the removal as the first patch in the series...
