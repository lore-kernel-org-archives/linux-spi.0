From: Schrempf Frieder <frieder.schrempf@kontron.De>
Subject: Re: [PATCH v4 00/10] Port the FSL QSPI driver to the SPI framework
Date: Wed, 7 Nov 2018 15:07:37 +0000
Message-ID: <c9b12dba-3922-9deb-e600-8a3aa1b3dfb5@kontron.de>
References: <1541601809-16950-1-git-send-email-frieder.schrempf@kontron.de>
 <20181107155315.056a0d47@bbrezillon>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "yogeshnarayan.gaur@nxp.com" <yogeshnarayan.gaur@nxp.com>,
 "richard@nod.at" <richard@nod.at>,
 "prabhakar.kushwaha@nxp.com" <prabhakar.kushwaha@nxp.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
 "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
 "han.xu@nxp.com" <han.xu@nxp.com>, "broonie@kernel.org" <broonie@kernel.org>,
 "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
 "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
 "fabio.estevam@nxp.com" <fabio.estevam@nxp.com>,
 "david.wolfe@nxp.com" <david.wolfe@nxp.com>,
 "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
 "dwmw2@infradead.org" <dwmw2@infradead.org>
To: Boris Brezillon <boris.brezillon@bootlin.com>
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <20181107155315.056a0d47@bbrezillon>
Content-Language: en-US
Content-ID: <3ADD87DD10437F48ADC999CE612FB42A@snt-world.com>
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

On 07.11.18 15:53, Boris Brezillon wrote:
> On Wed,  7 Nov 2018 15:43:17 +0100
> Frieder Schrempf <frieder.schrempf@kontron.de> wrote:
> 
>> Changes in v4:
>> ==============
>> * Rebase on top of v4.20-rc1
>> * Drop patches that were merged separately
>> * Address change of company name and email address
> 
> Looks like your SoB and Author fields are still using the old address.

I changed my git user email and git send-email added a "From:" field to 
each patch because the old SoB doesn't match the new git user config.

I can change the SoB fields in the next version.
______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
