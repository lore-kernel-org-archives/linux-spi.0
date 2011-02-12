From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH v7] spi: add OpenCores tiny SPI driver
Date: Sat, 12 Feb 2011 02:34:56 -0700
Message-ID: <AANLkTik6UcF0v43wRowV6+0xtKC6Kkwh30xvArefW23N@mail.gmail.com>
References: <1296964096-30760-1-git-send-email-thomas@wytron.com.tw>
	<1297143803-2771-1-git-send-email-thomas@wytron.com.tw>
	<20110212093120.GF17755@angua.secretlab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, nios2-dev-1eJk0qcHJCcaeqlQEoCUNoJY59XmG8rH@public.gmane.org,
	David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Thomas Chou <thomas-SDxUXYEhEBiCuPEqFHbRBg@public.gmane.org>
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <20110212093120.GF17755-MrY2KI0G/OVr83L8+7iqerDks+cytr/Z@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
	<mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
	<mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Sender: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Sat, Feb 12, 2011 at 2:31 AM, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org> wrote:
> On Tue, Feb 08, 2011 at 01:43:23PM +0800, Thomas Chou wrote:
>> This patch adds support of OpenCores tiny SPI driver.
>>
>> http://opencores.org/project,tiny_spi
>>
>> Signed-off-by: Thomas Chou <thomas-SDxUXYEhEBiCuPEqFHbRBg@public.gmane.org>
>> ---
>> v2 minor cleanup, same as Grant suggest for spi_altera.
>> v3 rename driver to spi_oc_tiny as Grant suggested.
>>    set version to tiny-spi-rtlsvn2 as Jonas suggested.
>> v4 add dts binding doc.
>> v5 use devm_* to help cleanup.
>>    add of gpio support.
>> v6 check len from of_get_property.
>>    fix kerneldoc in header.
>> v7 remove default n from Kconfig.
>>
>>  .../devicetree/bindings/spi/spi_oc_tiny.txt        |   12 +
>>  drivers/spi/Kconfig                                |    7 +
>>  drivers/spi/Makefile                               |    1 +
>>  drivers/spi/spi_oc_tiny.c                          |  421 ++++++++++++++++++++
>>  include/linux/spi/spi_oc_tiny.h                    |   20 +
>>  5 files changed, 461 insertions(+), 0 deletions(-)
>>  create mode 100644 Documentation/devicetree/bindings/spi/spi_oc_tiny.txt
>>  create mode 100644 drivers/spi/spi_oc_tiny.c
>>  create mode 100644 include/linux/spi/spi_oc_tiny.h
>
> Hi Thomas
>
> Still need documentation on the binding in
> Documentation/devicetree/bindings before I pick up this driver.  This
> goes for all the new drivers with dt bindings.

Oops, nevermind.  I see it.  Sorry for the noise.

g.
