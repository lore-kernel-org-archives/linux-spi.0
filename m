From: Huang Shijie <shijie8@gmail.com>
Subject: Re: [PATCH v4 0/7] mtd: spi-nor: add a new framework for SPI NOR
Date: Sun, 19 Jan 2014 10:44:06 +0800
Message-ID: <20140119024405.GA2321@gmail.com>
References: <1387950629-27448-1-git-send-email-b32955@freescale.com>
 <CAD6G_RTnNQgeJM8Tc16Sc1_n29d=V9sJN1ePrOAn5YzM+GujMQ@mail.gmail.com>
 <52D7A237.8@freescale.com>
 <CAD6G_RRNg-uRtKnnVgJYpUGPsKecAUm9mwETVJsCsaGSuL2eCw@mail.gmail.com>
 <20140117020226.GB27652@shlinux2.ap.freescale.net>
 <CAD6G_RR7vgmHGFj4GqwCYLQQO6tbsZAeCzVBivbcxnCGSwgiWQ@mail.gmail.com>
 <20140117065401.GA6140@shlinux2.ap.freescale.net>
 <CAD6G_RSF_TPk8g9CNmSc+xs+9psLmJoakZw3Eqf-a8KD5P4AVg@mail.gmail.com>
 <CAD6G_RT1m+7BWZyYqU7Pb2+bhki-Wqs6f96=GhMyF1nHyy2wuw@mail.gmail.com>
 <20980858CB6D3A4BAE95CA194937D5E73EA664C6@DBDE04.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Huang Shijie <b32955@freescale.com>,
	"angus.clark@st.com" <angus.clark@st.com>,
	Brian Norris <computersforpeace@gmail.com>,
	"b44548@freescale.com" <b44548@freescale.com>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	Lee Jones <lee.jones@linaro.org>,
	Mark Brown <broonie@linaro.org>,
	"b18965@freescale.com" <b18965@freescale.com>,
	"linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
	"Poddar, Sourav" <sourav.poddar@ti.com>,
	Shawn Guo <shawn.guo@linaro.org>,
	David Woodhouse <dwmw2@infradead.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	Jagan Teki <jagannadh.teki@gmail.com>
To: "Gupta, Pekon" <pekon@ti.com>
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20980858CB6D3A4BAE95CA194937D5E73EA664C6@DBDE04.ent.ti.com>
Sender: linux-doc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Fri, Jan 17, 2014 at 05:40:09PM +0000, Gupta, Pekon wrote:
> Hi Shijie,
> 
> >From: Jagan Teki [mailto:jagannadh.teki@gmail.com]
> [...]
> >
> >I feel these are good points to discuss all.
> >1. With new framework seems like we need two separate controller drivers
> >    one for non spi-nor and one for spi-nor with single controller hw
> >2. With spi-nor implementation though the hw is spi complaint but the sw is
> >   completely ignoring the Linux SPI core interaction.
> >
> >I feel above two points are technically wrong - Please correct me if am wrong
> >but need all developers will join..thanks!
> >
> I have been following this patch-set from sometime, And I think point (2)
> has been discussed back and forth in multiple times in earlier discussions.
> So, Is it possible for you to summarize point (2) with all pros-n-cons ?
> 
> - A README will helpful to clear all doubts and will ease your implementation
>   as well.
> - It will also help in reducing turn-around time to get this framework in
>    acceptable state and still keep it generic enough.
> 
> You can submit the README as Documentation/mtd/spi-nor.txt
okay.

thanks
Huang Shijie
