using System;
using System.Runtime.InteropServices;
using System.Security.Permissions;
using Microsoft.SharePoint;

namespace SharePointOnlineNews.Features.Activate.Branding
{
    /// <summary>
    /// This class handles events raised during feature activation, deactivation, installation, uninstallation, and upgrade.
    /// </summary>
    /// <remarks>
    /// The GUID attached to this class may be used during packaging and should not be modified.
    /// </remarks>

    [Guid("238a5db2-e5b8-437e-bea6-205b2e694694")]
    public class ActivateEventReceiver : SPFeatureReceiver
    {
        /// <summary>
        /// Occurs after a Feature is activated.
        /// </summary>
        /// <param name="properties">An <see cref="T:Microsoft.SharePoint.SPFeatureReceiverProperties" /> object that represents the properties of the event.</param>
        public override void FeatureActivated(SPFeatureReceiverProperties properties)
        {
            SPSite site = properties.Feature.Parent as SPSite;

            if (site != null)
            {
                SPWeb topLevelSite = site.RootWeb;

                // Calculate relative path to site from Web Application root.
                string webAppRelativePath = topLevelSite.ServerRelativeUrl;
                if (!webAppRelativePath.EndsWith("/"))
                {
                    webAppRelativePath += "/";
                }

                // Activate publishing infrastructure
                site.Features.Add(new Guid("f6924d36-2fa8-4f0b-b16d-06b7250180fa"), true);

                // Enumerate through each site and apply branding.
                foreach (SPWeb web in site.AllWebs)
                {
                    // Activate the publishing feature for all webs.
                    web.Features.Add(new Guid("94c94ca6-b32f-4da9-a9e3-1f3d343d7ecb"), true);
                    web.MasterUrl = webAppRelativePath + "_catalogs/masterpage/MyOnline.master";
                    web.CustomMasterUrl = webAppRelativePath + "_catalogs/masterpage/MyOnline.master";
                   
                    web.Update();
                }
            }
        }



        /// <summary>
        /// Occurs when a Feature is deactivated.
        /// </summary>
        /// <param name="properties">An <see cref="T:Microsoft.SharePoint.SPFeatureReceiverProperties" /> object that represents the properties of the event.</param>
        public override void FeatureDeactivating(SPFeatureReceiverProperties properties)
        {
            SPSite siteCollection = properties.Feature.Parent as SPSite;
            if (siteCollection != null)
            {
                SPWeb topLevelSite = siteCollection.RootWeb;

                // Calculate relative path to site from Web Application root.
                string webAppRelativePath = topLevelSite.ServerRelativeUrl;
                if (!webAppRelativePath.EndsWith("/"))
                {
                    webAppRelativePath += "/";
                }

                // Enumerate through each site and apply branding.
                foreach (SPWeb site in siteCollection.AllWebs)
                {
                    site.MasterUrl = webAppRelativePath + "_catalogs/masterpage/seattle.master";
                    site.CustomMasterUrl = webAppRelativePath + "_catalogs/masterpage/seattle.master";
                    site.SiteLogoUrl = string.Empty;
                    site.Update();
                }
            }
        }
    }
}
