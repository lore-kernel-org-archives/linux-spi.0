From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH 6/8] mmc: spi: Add SPI driver for mx233/mx28
Date: Thu, 5 Jul 2012 13:43:40 +0800
Message-ID: <CAAQ0ZWQEoOy6etXhsy3uTPmiFqtVaqMf5VXUHFrp3O6R_jQ06g@mail.gmail.com>
References: <1340958180-2291-1-git-send-email-marex@denx.de>
 <1340958180-2291-6-git-send-email-marex@denx.de>
 <20120705005143.GF2595@S2101-09.ap.freescale.net>
 <201207050739.49912.marex@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Fabio Estevam <fabio.estevam@freescale.com>, Wolfgang Denk <wd@denx.de>,
 Detlev Zundel <dzu@denx.de>, Rob Herring <rob.herring@calxeda.com>,
 Grant Likely <grant.likely@secretlab.ca>, Stefano Babic <sbabic@denx.de>,
 spi-devel-general@lists.sourceforge.net, Chris Ball <cjb@laptop.org>,
 Dong Aisheng <b29396@freescale.com>, linux-arm-kernel@lists.infradead.org
To: Marek Vasut <marex@denx.de>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <201207050739.49912.marex@denx.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org

On 5 July 2012 13:39, Marek Vasut <marex@denx.de> wrote:
>> So SPI_MXS may need to select STMP_DEVICE.
>
> Ok, fixed in my tree. But, where's the meteor shower of nitpicks and such stuff?

I do not take this as a nitpick at all.  Removing those drivers
selecting STMP_DEVICE from mxs_defconfig, your driver does not
compile.

Regards,
Shawn
