From: Kamal Dasu <kdasu.kdev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v5 1/8] Documentation: dt: spi: Add BRCMSTB SoC bindings
Date: Fri, 19 Aug 2016 11:07:19 -0400
Message-ID: <CAC=U0a2ONY_YQyOe+v1TJGmsUNcq_r0AN4B3-62ugojpmYT3cw@mail.gmail.com>
References: <1469830393-13295-1-git-send-email-kdasu.kdev@gmail.com>
 <1469830393-13295-2-git-send-email-kdasu.kdev@gmail.com> <20160816181944.GY9347@sirena.org.uk>
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
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160816181944.GY9347-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Tue, Aug 16, 2016 at 2:19 PM, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> On Fri, Jul 29, 2016 at 06:13:06PM -0400, Kamal Dasu wrote:
>> Added device tree bindings documentation for SoCs supported by the
>> new spi-bcm-qspi, spi-brcmstb-qspi driver.
>
> This doesn't document the clock-frequency property the driver
> implements.  However I'd recommend just dropping that since it appears
> to duplicate the existing facilities for setting the bus speed per slave
> device.

Will fix this and the subject for the patch.

Kamal
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
