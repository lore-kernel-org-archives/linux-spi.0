From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH v2 01/10] spi: tegra: Do not use clock name to get clock
Date: Mon, 14 Jan 2013 20:17:26 +0000
Message-ID: <20130114201726.C11F73E249D@localhost>
References: <1357891289-23500-1-git-send-email-pgaikwad@nvidia.com> <50F07CF4.2090502@wwwdotorg.org>
Cc: Prashant Gaikwad <pgaikwad-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	"spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org"
	<spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
To: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <50F07CF4.2090502-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Fri, 11 Jan 2013 13:58:28 -0700, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org> wrote:
> On 01/11/2013 01:01 AM, Prashant Gaikwad wrote:
> > Since Tegra spi devices do not have multiple clocks, no need to use
> > clock name to get the clock.
> 
> Cc'ing in the SPI maintainers as an FYI and for Acks; this patch needs
> to go through the Tegra tree due to dependencies.

Acked-by: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>

No problem merging it via the Tegra tree.

g.
