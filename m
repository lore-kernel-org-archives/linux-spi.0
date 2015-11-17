From: Joshua Clayton <stillcompiling-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 3/8] Documentation/spi/spidev_test.c: accept input from a file
Date: Tue, 17 Nov 2015 11:28:29 -0800
Message-ID: <5345438.ORMdKP6N7u@jclayton-pc>
References: <cover.1447773299.git.stillcompiling@gmail.com> <d90d749776cf562bc9922aff5e97cb911a77b22b.1447773299.git.stillcompiling@gmail.com> <564B716E.5020605@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Cc: Anton Bondarenko <anton.bondarenko.sama-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <564B716E.5020605-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Tuesday, November 17, 2015 07:26:54 PM Anton Bondarenko wrote:
> On 17.11.2015 16:24, Joshua Clayton wrote:
> > +	if (sb.st_size > 4096)
> > +		pabort("input file exceeds spidev's 4k limit");
> This is not a true. IIRC PAGE_SIZE is the default buffer size for 
> spidev, but can be changed using bufsiz module parameter.
> Just 'insmod spidev bufsiz=X', where X is number of bytes.

You are right. I will drop this. As Mark suggests.
The ioctl gives a nice error code if the buffer is too big.

...
> > +	tx = malloc(sb.st_size);
> It would be good to check new allocations for fail.

I will add a check for this. 

-- 
~Joshua Clayton
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
