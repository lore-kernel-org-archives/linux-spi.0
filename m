From: Julia Lawall <julia.lawall-L2FTfq7BK8M@public.gmane.org>
Subject: Re: devm_spi_register_master
Date: Sat, 16 Nov 2013 07:24:20 -0800 (PST)
Message-ID: <alpine.DEB.2.02.1311160718010.2762@hadrien>
References: <alpine.DEB.2.02.1311110935230.2300@hadrien> <20131116105029.GN15393@sirena.org.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20131116105029.GN15393-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Sat, 16 Nov 2013, Mark Brown wrote:

> On Mon, Nov 11, 2013 at 09:44:56AM -0800, Julia Lawall wrote:
>
> > I was looking into the use of devm_spi_register_master.  This function
> > seems to take care of registering and unregistering, but not allocation
> > and freeing.  I have the impression that that is done with
>
> Please CC maintainers on things using the addresses from MAINTAINERS - I
> didn't read these until now because you sent the mail to my work address
> which mostly gets duplicates of mails to the account I normally use for
> upstream so I tend not to pay so much attention to upstream mail sent
> there.  There's also other Mark Brown's working on the kernel so you
> might've got the wrong one!

Sorry about that.  I think I took the address from a patch, which was
obviously not the right thing to do.

> I think this has been addressed by the patches that Wei sent or are
> there still outstanding problems?

I didn't have a chance to check yet.  I will take a look now.

thanks,
julia
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
