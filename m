From: "Eric D." <eric.dillmann-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/3] spidev: Add DT binding example.
Date: Thu, 30 Apr 2015 07:03:57 -0700 (PDT)
Message-ID: <b7b1aa1a-e562-438e-a9c9-8d1ec8552da5@googlegroups.com>
References: <20150427173036.GA10950@lukather> <20150427180728.GW22845@sirena.org.uk>
 <cd282abf-898a-4f01-90a6-8bf2db160b8e@googlegroups.com> <CAOMqctRTFgnVEKDAx4roMcGOeGV35Dyz7oOsOa4jC-MKr9_xXg@mail.gmail.com>
 <20150428141630.GR22845@sirena.org.uk> <CAOMqctTNSgycy7K=ZMK9aaZGyybDT61e0Y6Fwf1jtoMbSVoNQQ@mail.gmail.com>
 <20150428171738.GY22845@sirena.org.uk> <CAOMqctSEAd-WeBRLabvDugN04XaqY6Y1UyO9UPLaTW9ce7t_rQ@mail.gmail.com>
 <20150429174059.GQ22845@sirena.org.uk> <CAOMqctQmpYmD0J9=o6FVjJhXBc8b+oGd7cNh5aH_fmgE3vk5+A@mail.gmail.com>
 <20150429180659.GT22845@sirena.org.uk> <CAOMqctSMeWvG6YsCFn5=wxS2nCBbMiiCKUNJh8oFsH1VZY4H-w@mail.gmail.com>
 <CAMuHMdXtL=-JWiXNbpwBEc+oMAVpBq1ShqZhFVKZRO_x9Xq4tA@mail.gmail.com>
 <CAOMqctQD8+bJevuOWRNx6LFfD_QXLGeNLqmVUhfsSdPrxyv6bQ@mail.gmail.com>
Reply-To: eric.dillmann-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_8522_466906661.1430402637268"
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org,
	eric.dillmann-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org,
	maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, corbet-T1hC0tSOHrs@public.gmane.org,
	hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Return-path: <linux-sunxi+bncBDD6NW6IFYIM33EIVICRUBHTBCLOW-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <CAOMqctQD8+bJevuOWRNx6LFfD_QXLGeNLqmVUhfsSdPrxyv6bQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <http://groups.google.com/group/linux-sunxi/subscribe>
List-Id: linux-spi.vger.kernel.org

------=_Part_8522_466906661.1430402637268
Content-Type: multipart/alternative;
	boundary="----=_Part_8523_395005289.1430402637269"

------=_Part_8523_395005289.1430402637269
Content-Type: text/plain; charset=UTF-8

Hi,

I give Maxime's patch a try, but get divide by zero in kernel traces due to 
spi max speed not being setted.
I then tried declaring spidev in the DT, and my application just work's.
Adding spi0 alias in DT give's me a beautyful /dev/spidev0.0, where 
Maxime's was creating /dev/spidev0.[0-3] nodes.

Thanks
Eric
------=_Part_8523_395005289.1430402637269--

------=_Part_8522_466906661.1430402637268--
