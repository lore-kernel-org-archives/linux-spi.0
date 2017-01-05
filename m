From: Phil Reid <preid-qgqNFa1JUf/o2iN0hyhwsIdd74u8MsAO@public.gmane.org>
Subject: Re: Applied "spi: dw: Make debugfs name unique between instances" to
 the spi tree
Date: Thu, 5 Jan 2017 10:29:02 +0800
Message-ID: <af8816db-331d-d9cc-0178-c99fb612f555@electromag.com.au>
References: <1482398292-46946-1-git-send-email-preid@electromag.com.au>
 <E1cOqRP-00026r-Q6@debutante>
 <CAHp75VccfSoo1yq60G9X=_WxKKR3pwiQvBkqA6vyFthDrKxPDA@mail.gmail.com>
 <20170105010146.iyo5mvfjzd555egm@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: kernel-NoMTM8u0nx3R7s880joybQ@public.gmane.org, Jisheng Zhang <jszhang-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>,
        linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170105010146.iyo5mvfjzd555egm-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

G'day Mark,
On 5/01/2017 09:01, Mark Brown wrote:
> On Thu, Jan 05, 2017 at 12:45:48AM +0200, Andy Shevchenko wrote:
>> On Wed, Jan 4, 2017 at 8:37 PM, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
>
>>> Please add any relevant lists and maintainers to the CCs when replying
>>> to this mail.
>
>> Hmm... We are still discussing the approach.
>
> I applied this before you started discussing the approach...
>

There was a v2 of the patch sent Tue 12:54 +0800
Which uses the bus number.
There's also a problem with the name registering the name of the irq.

Please let me know how to proceed.
Should I apply new patches against v1 of this patch now?
-- 
Regards
Phil Reid

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
