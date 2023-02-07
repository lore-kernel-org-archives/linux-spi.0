Return-Path: <linux-spi-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26B7BC636CC
	for <linux-spi@archiver.kernel.org>; Tue,  7 Feb 2023 05:55:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbjBGFzx (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Tue, 7 Feb 2023 00:55:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjBGFzx (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 7 Feb 2023 00:55:53 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EDF5DBF6;
        Mon,  6 Feb 2023 21:55:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675749352; x=1707285352;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hU5gUO2J8zNMD/8YKlpaTw/mW59EnWX72+6Ki4ELyrs=;
  b=WTN6sVyCa7fV1izAtG3yihdcKI0w28/d/bn6dOfyifI/yMmvpvWKQ0z3
   3CN2qbZKTu5D2FVoDKI3Wm7PnVEZbcqLrLYOM5mXGnEhvU9qMSYQ6d/Lh
   zNL3yGpDRU0tcpkDchz08NA7PbXg5kj+giaYg+PaWHusMX3PSMXwlxpLH
   He2CocekAFcXcuH1A9Y6nFwsEewxVyVlYymB6Je5BjKo0o4Z2RxrQXBt4
   eAGD63C/QNjzYv4UqKze3HrY8OtUE/aHxYpc063xSnX803q4gVGCYOUTD
   8dDbV4D+Qj4AgBzaiv+BVOQ1KXhN81F0eg/XEO/31ssnVJK4y38uMc82y
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="391809606"
X-IronPort-AV: E=Sophos;i="5.97,278,1669104000"; 
   d="scan'208";a="391809606"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2023 21:55:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="790672560"
X-IronPort-AV: E=Sophos;i="5.97,278,1669104000"; 
   d="scan'208";a="790672560"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 06 Feb 2023 21:55:50 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id C510F1C5; Tue,  7 Feb 2023 07:56:28 +0200 (EET)
Date:   Tue, 7 Feb 2023 07:56:28 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Mauro Lima <mauro.lima@eclypsium.com>
Cc:     broonie@kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] spi: intel: Remove DANGEROUS tag from pci driver
Message-ID: <Y+HoDOgKzRn7riXS@black.fi.intel.com>
References: <20230206183143.75274-1-mauro.lima@eclypsium.com>
 <20230206183143.75274-2-mauro.lima@eclypsium.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230206183143.75274-2-mauro.lima@eclypsium.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi,

One nit: In $subject please use PCI instead of pci.

On Mon, Feb 06, 2023 at 03:31:43PM -0300, Mauro Lima wrote:
> Modern CPUs exposes this controller as PCI device that only uses
> hardware sequencing capabilities which is safer than software
> sequencing.
> Leave the platform driver as *DANGEROUS* and update help text since
> most of these controllers are using software sequencing.
> 
> Signed-off-by: Mauro Lima <mauro.lima@eclypsium.com>

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
