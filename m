From: "Manjunathappa, Prakash" <prakash.pm-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH 0/4] Enable SPI flash support on da850-evm DT kernel
Date: Wed, 27 Feb 2013 11:32:39 +0000
Message-ID: <A73F36158E33644199EB82C5EC81C7BC3EA47FEF@DBDE01.ent.ti.com>
References: <1361789050-637-1-git-send-email-prakash.pm@ti.com>
 <512DC65D.7080603@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org"
 <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>,
 "linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org" <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>,
 "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>,
 "rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org" <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>,
 "spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org"
 <spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, "hs-ynQEQJNshbs@public.gmane.org" <hs-ynQEQJNshbs@public.gmane.org>,
 "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
To: "Nori, Sekhar" <nsekhar-l0cyMroinI0@public.gmane.org>, "grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org"
 <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <512DC65D.7080603-l0cyMroinI0@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Id: linux-spi.vger.kernel.org

On Wed, Feb 27, 2013 at 14:09:57, Nori, Sekhar wrote:
> On 2/25/2013 4:14 PM, Manjunathappa, Prakash wrote:
> > Patch enables support for m25p80 SPI flash support on
> > da850-EVM.
> > 
> > Testing information:
> > da850-evm comes with partitions specified in DT blob.
> > Able to mount/umount and create/delete files on filesystem partition.
> > 
> > Depends on below patch in spi-next branch of git://git.secretlab.ca/git/linux-2.6.git.
> > "spi/davinci: add OF support for the spi controller"
> > 

Grant,
I could not find binding documentation changes submitted with above patch.
I checked in spi-next and linux-next.

> > Applies on top of below patch under community review:
> > http://www.mail-archive.com/davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org/msg25184.html
> 
> The series looks good to me except a minor comment I gave on 4/4. Patch
> 1/4 should be picked by Grant (ideally before v3.9-rc1). I will queue
> rest of patches for v3.10.
> 

Thanks for review Sekhar, I will put your Acked-by for 1/4 for v2 of this series.

Regards,
Prakash
