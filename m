From: Julia Lawall <julia.lawall-L2FTfq7BK8M@public.gmane.org>
Subject: Re: [PATCH 1/3] spi: Add helper functions for setting up transfers
Date: Thu, 10 Jan 2013 09:53:17 +0100 (CET)
Message-ID: <alpine.DEB.2.02.1301100951060.2063@localhost6.localdomain6>
References: <1357752671-30222-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>,
	linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1357752671-30222-1-git-send-email-lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

> +@r1@
> +identifier fn;
> +identifier xfers;
> +@@
> +fn(...)
> +{
> +	...
> +(
> +	struct spi_transfer xfers[...];
> +|
> +	struct spi_transfer xfers[];
> +)
> +	...
> +}

Can it happen that there would be more than one spi_transfer or spi_message
variable per function?  This semantic patch will only treat the case where
there is only one, because the ... before an after the variable declaration
won't match another declaration of the same form.

julia
