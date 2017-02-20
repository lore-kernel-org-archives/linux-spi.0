From: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Subject: Re: [PATCH v4 1/2] mtd: spi-nor: Added spi-nor init function
Date: Mon, 20 Feb 2017 09:12:08 +0100
Message-ID: <CACna6rzV3xNSyGGmDvTvbfMVp=iAZdXBQpniKFULKOtBW_6aow@mail.gmail.com>
References: <1487086368-4118-1-git-send-email-kdasu.kdev@gmail.com>
 <1487086368-4118-2-git-send-email-kdasu.kdev@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Marek Vasut <marex@denx.de>, Florian Fainelli <f.fainelli@gmail.com>,
 linux-spi <linux-spi@vger.kernel.org>, Mark Brown <broonie@kernel.org>,
 bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
 "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
 Cyrille Pitchen <cyrille.pitchen@atmel.com>
To: Kamal Dasu <kdasu.kdev@gmail.com>
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <1487086368-4118-2-git-send-email-kdasu.kdev@gmail.com>
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

On 14 February 2017 at 16:32, Kamal Dasu <kdasu.kdev@gmail.com> wrote:
> Refactored spi_nor_scan() code to add spi_nor_init() function that
> programs the spi-nor flash to:
> 1) remove flash protection if applicable
> 2) set read mode to quad mode if configured such
> 3) set the address width based on the flash size and vendor
>
> spi_nor_scan() now calls spi_nor_init() to setup nor flash.
>
> Signed-off-by: Kamal Dasu <kdasu.kdev@gmail.com>

Ideally a short reason info should go there.
"This allows reusing spi_nor_init during resume"
or whatever :)

______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
