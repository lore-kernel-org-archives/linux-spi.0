From: Schrempf Frieder <frieder.schrempf@kontron.de>
Subject: Re: [PATCH] spi: spi-mem: spi-fsl-qspi: typo fix in author name
Date: Tue, 29 Jan 2019 12:08:26 +0000
Message-ID: <24c8ce00-5a7c-cec0-df5b-fca6e13bccb0@kontron.de>
References: <1548755607-27544-1-git-send-email-yogeshnarayan.gaur@nxp.com>
 <4759d7a9-71a2-70a7-2704-0ef7fa37b2ca@kontron.de>
 <20190129115937.GB10524@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>,
 "bbrezillon@kernel.org" <bbrezillon@kernel.org>,
 "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
 "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
 "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>,
 "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
 "computersforpeace@gmail.com" <computersforpeace@gmail.com>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <20190129115937.GB10524@sirena.org.uk>
Content-Language: en-US
Content-ID: <BDB7042F81914B458C296A633E14A759@snt-world.com>
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

On 29.01.19 12:59, Mark Brown wrote:
> On Tue, Jan 29, 2019 at 11:46:02AM +0000, Schrempf Frieder wrote:
> 
>> Mark, could you please squash this with the original commit
>> (84d043185dbe spi: Add a driver for the Freescale/NXP QuadSPI
>> controller) in spi-next?
> 
> That'd mean a rebase unfortunately.

Ah, ok no problem. Then please just apply it with:

Fixes: 84d043185dbe ("spi: Add a driver for the Freescale/NXP QuadSPI 
controller")
______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
