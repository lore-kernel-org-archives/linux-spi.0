From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Subject: Re: [PATCH 1/5] MAINTAINERS: add ADIS IMU driver library entry
Date: Wed, 26 Jun 2019 19:32:47 +0100
Message-ID: <20190626193247.09006ac4@archlinux>
References: <20190625131328.11883-1-alexandru.ardelean@analog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: <linux-iio@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
To: Alexandru Ardelean <alexandru.ardelean@analog.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190625131328.11883-1-alexandru.ardelean@analog.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Tue, 25 Jun 2019 16:13:24 +0300
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> This change adds the ADIS driver library to the MAINTAINERS list, and adds
> myself as the current maintainer of this library.
> 
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Hi Alexandru,

Given this only has a tangential relationship to the rest of the patches
I'll pick up now.

More generally this series is complex enough a cover letter would have
been good + 5/5 isn't anywhere that I can find?


Thanks,

Jonathan

> ---
>  MAINTAINERS | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 1eb971608ac4..544e23753e96 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -930,6 +930,13 @@ S:	Supported
>  F:	drivers/mux/adgs1408.c
>  F:	Documentation/devicetree/bindings/mux/adi,adgs1408.txt
>  
> +ANALOG DEVICES INC ADIS DRIVER LIBRARY
> +M:	Alexandru Ardelean <alexandru.ardelean@analog.com>
> +S:	Supported
> +L:	linux-iio@vger.kernel.org
> +F:	include/linux/iio/imu/adis.h
> +F:	drivers/iio/imu/adis.c
> +
>  ANALOG DEVICES INC ADP5061 DRIVER
>  M:	Stefan Popa <stefan.popa@analog.com>
>  L:	linux-pm@vger.kernel.org
