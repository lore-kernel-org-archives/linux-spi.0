From: Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: spi: OF module autoloading is still broken
Date: Mon, 16 Nov 2015 12:47:02 -0800
Message-ID: <20151116204702.GP8456@google.com>
References: <56104E88.3040807@gmail.com>
 <20151112185926.GC8456@google.com>
 <20151113194031.GI8456@google.com>
 <20151113221228.GT12392@sirena.org.uk>
 <20151113225113.GJ8456@google.com>
 <20151113231410.GV12392@sirena.org.uk>
 <20151113234857.GK8456@google.com>
 <564A101F.9090807@osg.samsung.com>
 <20151116192434.GO8456@google.com>
 <564A35EB.5080008@osg.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <564A35EB.5080008-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi,

On Mon, Nov 16, 2015 at 05:00:43PM -0300, Javier Martinez Canillas wrote:
> On 11/16/2015 04:24 PM, Brian Norris wrote:

> I also didn't think about wilcards... I wonder why there are trailing
> wildcards for a compatible string. After all a compatible string should
> define a particular IP and there could be a foo,bar and foo,barbaz that
> have different drivers and what prevents today the driver with alias
> of:N*T*Cfoo,bar* to be loaded due a MODALIAS=of:NfooT<NULL>Cfoo,barbar ?
> 
> So I think we need this regardless of my patch:
> 
> diff --git a/scripts/mod/file2alias.c b/scripts/mod/file2alias.c
> index 5b96206e9aab..cd0002f4a199 100644
> --- a/scripts/mod/file2alias.c
> +++ b/scripts/mod/file2alias.c
> @@ -704,7 +704,6 @@ static int do_of_entry (const char *filename, void *symval, char *alias)
>  		if (isspace (*tmp))
>  			*tmp = '_';
>  
> -	add_wildcard(alias);
>  	return 1;
>  }
>  ADD_TO_DEVTABLE("of", of_device_id, do_of_entry);

(I'm also not an expert in this stuff, but...) That looks reasonable.
You might refer to commit ac551828993e ("modpost: i2c aliases need no
trailing wildcard") for inspiration. You might also modify the "always"
in:

/* Always end in a wildcard, for future extension */
static inline void add_wildcard(char *str)
{
	...
}

And of course, you probably should CC those who are responsible for the
core device tree probing and device/driver interactions for something
like this.

> Now that I think about it, there is another issue and is that today spi:foo
> defines a namespace while changing to of: will make the namespace flat so
> a platform driver that has the same vendor and model will have the same
> modalias.
> 
> IOW, for board files will be platform:bar and i2c:bar while for OF will be
> of:NfooT<NULL>Cfoo,bar in both cases. I wonder if we should reuse the type
> for that and store the subsystem prefix there. What do you think?

I'm not sure I understand all the issues here to be able to comment
properly. But I bet someone else might.

(For me, it might help if you had a more concrete example to speak of.)

> Thanks a lot for pointing out all these issues. It is indeed harder than
> I thought.

No problem!

> > I don't think you have problems only with bad FDTs. I think you have a
> > problem with perfectly valid DTs.
> >
> 
> Agreed, I wonder if spi_uevent() shouldn't be changed to report both the
> OF and old SPI modaliases to avoid breaking a lot of drivers but at the
> same time allowing DT-only drivers to not need an SPI ID table.

That's the solution I imagined, though I haven't tested it yet. I don't
see much precedent for reporting multiple modaliases, so there could be
some kind of ABI issues around that too.

Regards,
Brian
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
