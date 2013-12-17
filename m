From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH v3 0/7] mtd: spi-nor: add a new framework for SPI NOR
Date: Tue, 17 Dec 2013 15:56:51 +0800
Message-ID: <20131217075649.GL6691@S2101-09.ap.freescale.net>
References: <1387184330-14448-1-git-send-email-b32955@freescale.com>
 <20980858CB6D3A4BAE95CA194937D5E73EA56ADC@DBDE04.ent.ti.com>
 <20131217040209.GA27091@shlinux2.ap.freescale.net>
 <20980858CB6D3A4BAE95CA194937D5E73EA56B3A@DBDE04.ent.ti.com>
 <20131217060731.GJ6691@S2101-09.ap.freescale.net>
 <20980858CB6D3A4BAE95CA194937D5E73EA56C5B@DBDE04.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: Huang Shijie <b32955@freescale.com>,
	"mike@steroidmicros.com" <mike@steroidmicros.com>,
	"dwmw2@infradead.org" <dwmw2@infradead.org>,
	"computersforpeace@gmail.com" <computersforpeace@gmail.com>,
	"broonie@linaro.org" <broonie@linaro.org>,
	"angus.clark@st.com" <angus.clark@st.com>,
	"lee.jones@linaro.org" <lee.jones@linaro.org>,
	"marex@denx.de" <marex@denx.de>,
	"Poddar, Sourav" <sourav.poddar@ti.com>,
	"linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
	"linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"b44548@freescale.com" <b44548@freescale.com>,
	"b18965@freescale.com" <b18965@freescale.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To: "Gupta, Pekon" <pekon@ti.com>
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20980858CB6D3A4BAE95CA194937D5E73EA56C5B@DBDE04.ent.ti.com>
Sender: linux-doc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Tue, Dec 17, 2013 at 07:17:01AM +0000, Gupta, Pekon wrote:
> All I said was using company names in Headers or MODULE_AUTHOR of
> *generic frameworks*. A generic framework is maintained and updated
> by community at large. And over course of time other people contribute
> more than the author. So tagging a company name there would sound like
> _repeatedly_ giving credit to company or yourself, even if most of the
> original  code is changed now. Does that make sense ?

I could somehow buy in the argument of using person email over company
one in MODULE_AUTHOR(), but still not the one that do not use company
name in Headers.

In this case, Huang works for Freescale and Freescale pays him to do the
work, so Huang shares the authorship and Freescale shares the copyright.
There is nothing wrong adding Freescale copyright into the file header,
based on my understanding.  When other people make significant changes
and contributions to the file, they are welcomed to add more copyright
info on top of the existing ones.

I'm not a lawyer, and more than happy to be corrected if I'm wrong.

Shawn

