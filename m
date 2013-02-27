From: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 0/4] Enable SPI flash support on da850-evm DT kernel
Date: Wed, 27 Feb 2013 14:09:57 +0530
Message-ID: <512DC65D.7080603@ti.com>
References: <1361789050-637-1-git-send-email-prakash.pm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>, <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>,
        <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>,
        <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, <spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
        <hs-ynQEQJNshbs@public.gmane.org>, <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
To: "Manjunathappa, Prakash" <prakash.pm-l0cyMroinI0@public.gmane.org>
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <1361789050-637-1-git-send-email-prakash.pm-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <http://linux.davincidsp.com/mailman/options/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.davincidsp.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
Errors-To: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On 2/25/2013 4:14 PM, Manjunathappa, Prakash wrote:
> Patch enables support for m25p80 SPI flash support on
> da850-EVM.
> 
> Testing information:
> da850-evm comes with partitions specified in DT blob.
> Able to mount/umount and create/delete files on filesystem partition.
> 
> Depends on below patch in spi-next branch of git://git.secretlab.ca/git/linux-2.6.git.
> "spi/davinci: add OF support for the spi controller"
> 
> Applies on top of below patch under community review:
> http://www.mail-archive.com/davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org/msg25184.html

The series looks good to me except a minor comment I gave on 4/4. Patch
1/4 should be picked by Grant (ideally before v3.9-rc1). I will queue
rest of patches for v3.10.

Thanks,
Sekhar
