From: Kamal Dasu <kdasu.kdev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v5 4/8] mtd: m25p80: Let m25p80_read() fallback to spi transfer
Date: Fri, 19 Aug 2016 10:59:47 -0400
Message-ID: <CAC=U0a3sDaiwRhAEZW0u_itaD7o3oUTRAEdDi_O3r9yZSr+cjA@mail.gmail.com>
References: <1469830393-13295-1-git-send-email-kdasu.kdev@gmail.com>
 <1469830393-13295-5-git-send-email-kdasu.kdev@gmail.com> <20160804210747.GN10383@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        MTD Maling List <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
        vigneshr-l0cyMroinI0@public.gmane.org, Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        "Jayachandran C <jchandra-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, bcm-kernel-feedback-list"
        <bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>,
        Vikram Prakash <vikram.prakash-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>,
        Andy Fung <andy.fung-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>,
        Jon Mason <jon.mason-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>,
        "Jayachandran C <jchandra-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, bcm-kernel-feedback-list"
        <jchandra-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160804210747.GN10383-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Adding Brian for this particular patch since its in the mtd domain. I
will specifically  add him as well in the next  patch set.  I do have
Vignesh in the list who added the spi_flash_read() in the list.

Kamal

On Thu, Aug 4, 2016 at 5:07 PM, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> On Fri, Jul 29, 2016 at 06:13:09PM -0400, Kamal Dasu wrote:
>> In m25p80_read() even though spi_flash_read() is supported
>> by some drivers, under certain circumstances like unaligned
>> buffer, address or address range limitations on certain SoCs
>> let it fallback to core spi reads. Such drivers are expected
>> to return -EAGAIN so that the m25p80_read() uses standard
>> spi transfer.
>
> You need to send this to the MTD maintainers, I see you've CCed the list
> but not Brian and any comaintainers he has AFAICT.
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
