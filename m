From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [PATCH v2 5/6] spi: davinci: do not use DMA if transfer length is
 less than 16
Date: Fri, 17 Feb 2017 17:55:01 +0100
Message-ID: <CAK8P3a2_FL2rBcHdmK040LMRMZCV-70pOBFVUh=VpO+q45nQ0Q@mail.gmail.com>
References: <1487327904-28311-1-git-send-email-fisaksen@baylibre.com>
 <1487327904-28311-6-git-send-email-fisaksen@baylibre.com> <CAK8P3a24HkxrU-6a727RY5JqwQgyf9SpprPXvurSqf1Q_W_AMQ@mail.gmail.com>
 <3358b5f1-c7b6-0955-0c36-6f135a585762@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: nsekhar-l0cyMroinI0@public.gmane.org, Kevin Hilman <khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>,
        ptitiano-rdvid1DuHRBWk0Htik3J/w@public.gmane.org,
        Linux ARM <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Frode Isaksen <fisaksen-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <3358b5f1-c7b6-0955-0c36-6f135a585762-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Fri, Feb 17, 2017 at 5:43 PM, Frode Isaksen <fisaksen-rdvid1DuHRBWk0Htik3J/w@public.gmane.org> wrote:
> On 17/02/2017 17:37, Arnd Bergmann wrote:
>> On Fri, Feb 17, 2017 at 11:38 AM, Frode Isaksen <fisaksen-rdvid1DuHRBWk0Htik3J/w@public.gmane.org> wrote:
>> 16 seems low as the cutoff. Have you found this experimentally and
>> tested that for e.g. 32
>> bytes there is actually an advantage in using DMA?
> Yes, I have tested for different sizes. Actually 32 bytes is better @30MHz, but if the bit rate goes down, DMA wins over PIO. Do you prefer 32 bytes ?

No, I don't care about the specific value, just making sure that you had
actually tested this, as I had expected PIO to be faster here.

     Arnd
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
