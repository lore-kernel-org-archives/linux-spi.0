From: Colin Cross <ccross-z5hGa2qSFaRBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 1/2] gpio/tegra: Move Tegra gpio driver to drivers/gpio
Date: Wed, 15 Jun 2011 13:21:56 -0700
Message-ID: <BANLkTinij15PZw11Y3Qt=PV1kkP1pw1oaszTdMfD55Cf8cOJkw@mail.gmail.com>
References: <20110615193734.23641.8004.stgit@ponder>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
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
In-Reply-To: <20110615193734.23641.8004.stgit@ponder>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Wed, Jun 15, 2011 at 12:37 PM, Grant Likely
<grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org> wrote:
> As part of the gpio driver consolidation, this patch moves the Tegra driver
> into drivers/gpio
>
> Signed-off-by: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
> ---
>
> If there are no objections, I'll merge this via gpio/next

I have this patch as part of a series that should get posted later
this week, as well as a patch on top of it that depends on this change
and another change in my tree, but I'm pessimistic that my series will
get in to 3.1 since it depends on some common consolidation that
hasn't been agreed upon yet.  So,
Acked-by: Colin Cross <ccross-z5hGa2qSFaRBDgjK7y7TUQ@public.gmane.org>

Put it in gpio/next, and I'll make sure any other Tegra patches with
dependencies get pulled after yours.
