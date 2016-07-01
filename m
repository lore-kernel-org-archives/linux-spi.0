From: Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2 3/3] drivers core: allow id match override when
 manually binding driver
Date: Fri, 1 Jul 2016 10:58:34 +0200
Message-ID: <CAOMqctRp+ua1DM82W35Df17TvhoF2suxALBaYqECWtTRrTWXCw@mail.gmail.com>
References: <20160627221259.GA10054@kroah.com> <CAOMqctTQAY0NzTpEqyLyScu8UrSXcF82oLVMM+e2F2WQ225B7A@mail.gmail.com>
 <20160628155107.GP17217@sirena.org.uk> <CAOMqctQbFmWv04idz7G+dPOCg7n-E0AQdhGAyohUDBniKvrP_g@mail.gmail.com>
 <20160628183825.GS17217@sirena.org.uk> <CAOMqctTNmcg32PFVOZaA99GpFba9GOGOuOqmi3ujzxcHRFZsOA@mail.gmail.com>
 <20160628205736.GE17217@sirena.org.uk> <CAOMqctS2xGCgfXschxudcAEYq-mcfPDmFS_pTzCuXa0bFBE0NA@mail.gmail.com>
 <20160629180211.GF6247@sirena.org.uk> <CAOMqctR-f+dNBiWk8LEqkeYMhpvACjMi8aH3GpHY==RjfANf8Q@mail.gmail.com>
 <20160701082548.GE6247@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>,
	Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160701082548.GE6247-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 1 July 2016 at 10:25, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> On Thu, Jun 30, 2016 at 09:47:32AM +0200, Michal Suchanek wrote:
>
>> So to write such tutorial you have to give some steps to follow which
>> are reasonably likely to succeed on wide variety of boards and require
>> smallest possible changes to the board software.
>
>> For mainline this would currently entail
>
> It's been repeatedly suggested to you that the tooling for this stuff
> could use some work.  Please go and put some effort into that rather
> than continuing this thread which is accomplishing nothing.

You completely miss the point. No tooling will make people reconfigure
the kernel when the configuration in fact stays the same.

Sure the tooling does need work. And it would help getting the cases
when the tooling is NOT needed out of the way.

Thanks

Michal
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
