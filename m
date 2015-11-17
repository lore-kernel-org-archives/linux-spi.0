From: Joshua Clayton <stillcompiling-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/8] Documentation/spi/spidev_test.c: clean up input_tx
Date: Tue, 17 Nov 2015 11:21:12 -0800
Message-ID: <5345436.HCqatbevmx@jclayton-pc>
References: <cover.1447773299.git.stillcompiling@gmail.com> <7f2139b27013d77993c6bc2b0a6c94fab01add98.1447773299.git.stillcompiling@gmail.com> <20151117174333.GY31303@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jonathan Corbet <corbet-T1hC0tSOHrs@public.gmane.org>,
	Adrian Remonda <adrianremonda-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20151117174333.GY31303-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Tuesday, November 17, 2015 05:43:33 PM Mark Brown wrote:
> On Tue, Nov 17, 2015 at 07:24:22AM -0800, Joshua Clayton wrote:
> > Put input from string into its own function.
> 
> Again, why are we doing this?  I'm having a hard time seeing what the
> gain is, the amount of code being moved is tiny.

It takes some clutter out of main() whose scope is limited to that little block of code, 
and because in the next patch we add another (larger)function to the if/else block.

I don't know if it is valid to say "look at the next commit" for justification, but
That is the reason.

-- 
~Joshua Clayton
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
