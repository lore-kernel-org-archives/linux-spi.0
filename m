From: Javier Martinez Canillas <javier.martinez-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
Subject: Re: [PATCH 0/4] spi: s3c64xx: fix DT binding breakage
Date: Wed, 16 Jul 2014 18:33:42 +0200
Message-ID: <53C6A966.10409@collabora.co.uk>
References: <1405523950-2231-1-git-send-email-javier.martinez@collabora.co.uk> <20140716160249.GS17528@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Naveen Krishna Chatradhi <ch.naveen-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>,
	Tomasz Figa <t.figa-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>,
	Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>,
	Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>,
	Kukjin Kim <kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>,
	Sachin Kamat <sachin.kamat-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>,
	devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140716160249.GS17528-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 07/16/2014 06:02 PM, Mark Brown wrote:
> On Wed, Jul 16, 2014 at 05:19:06PM +0200, Javier Martinez Canillas wrote:
> 
> *sigh*  Yesterday Naveen submitted another, different, patch series also
> attempting to improve things which I'm not seeing any reference to here.
> Please coordinate with Naveen about what you are doing.
> 

Yes, I answered Naveen on his latest series and told him that I thought his v6
was better and also that the commit messages where still not clearly explaining
the motivation for the changes [0].

So after that I asked him in private if he wouldn't mind if I try to rework his
series to make it easier to understand and he agreed on that. I should had
mentioned it the cover later, sorry about that.

Please take a look to this series instead of the latest that was posted by Naveen.

Thanks a lot and best regards,
Javier

[0]: https://www.mail-archive.com/devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org/msg34860.html
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
