From: "Gupta, Pekon" <pekon@ti.com>
Subject: RE: [PATCH v3 0/7] mtd: spi-nor: add a new framework for SPI NOR
Date: Tue, 17 Dec 2013 05:00:53 +0000
Message-ID: <20980858CB6D3A4BAE95CA194937D5E73EA56B3A@DBDE04.ent.ti.com>
References: <1387184330-14448-1-git-send-email-b32955@freescale.com>
 <20980858CB6D3A4BAE95CA194937D5E73EA56ADC@DBDE04.ent.ti.com>
 <20131217040209.GA27091@shlinux2.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "marex@denx.de" <marex@denx.de>, "angus.clark@st.com" <angus.clark@st.com>,
 "b44548@freescale.com" <b44548@freescale.com>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "b18965@freescale.com" <b18965@freescale.com>,
 "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
 "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, "Poddar,
 Sourav" <sourav.poddar@ti.com>, "shawn.guo@linaro.org" <shawn.guo@linaro.org>,
 "lee.jones@linaro.org" <lee.jones@linaro.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
To: Huang Shijie <b32955@freescale.com>, "mike@steroidmicros.com"
 <mike@steroidmicros.com>, "dwmw2@infradead.org" <dwmw2@infradead.org>,
 "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
 "broonie@linaro.org" <broonie@linaro.org>
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <20131217040209.GA27091@shlinux2.ap.freescale.net>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: "linux-mtd" <linux-mtd-bounces@lists.infradead.org>
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org

>From: Huang Shijie [mailto:b32955@freescale.com]
>On Tue, Dec 17, 2013 at 04:08:33AM +0000, Gupta, Pekon wrote:
>>
>> As much base code is copied from m25p90.c,
>> Do you mind keeping the sign-offs of the original contributors of m25p80.c
>> at-least in patches where much code is ported ?
>I have added the lines in the spi-nor.c:
>
> " Cloned most of the code from the m25p80.c"
>
>> This would at-least give some credit to original authors and contributors.
>I do not change any authors information of m25p80.c.
>
>If it is not enough?  Could you remind me what to do ?
>
(1) Add sign-offs of main authors of m25p80, so that original contributors
 still remains in path of submission [1].

(2) Also, please remove following from spi-nor.c
  However, you can keep this in fsl-quadspi.c.
  +MODULE_AUTHOR("Freescale Semiconductor Inc.");
  I'm sure this was _not_ present in original m25p80.c
 (m25p80.c was started as ST's driver as per MODULE_DESCRIPTION)

(3)     +MODULE_LICENSE("GPL");
Also, I assume the license version should be "GPLv2" ?

Request you please _not_ to tag generic driver frameworks with any
specific company names, and let open-source be independent of any
commercial company tags. Otherwise eventually everything generic driver
will have some or other company name associated with it.
And this should be followed by everyone (include myself).

I'm not sure why maintainers are not objecting to this. David, Brian ??


[1] https://www.kernel.org/doc/Documentation/SubmittingPatches
"12) Sign your work"


with regards, pekon

______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
